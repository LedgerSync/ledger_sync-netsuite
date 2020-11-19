# frozen_string_literal: true

# Define globally so it's only evaluated once.

module LedgerSync
  module Test
    class NetSuiteRecord < Record
      def id
        hash.fetch('Id', nil)
      end
    end
  end
end

NETSUITE_RECORD_COLLECTION = LedgerSync::Test::RecordCollection.new(
  dir: File.join(LedgerSync::NetSuite.root, 'spec/support/records'),
  record_class: LedgerSync::Test::NetSuiteRecord
)

module NetSuiteHelpers # rubocop:disable Metrics/ModuleLength
  def authorized_headers(override = {})
    {
      'Accept' => 'application/json',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Content-Type' => 'application/json',
      'User-Agent' => /.*/
    }.merge(override)
  end

  def api_record_url(args = {})
    _record = args.fetch(:record)
    id      = args.fetch(:id, nil)
    params  = args.fetch(:params, {})

    resource_endpoint = netsuite_client.class.ledger_resource_type_for(resource_class: resource.class).pluralize
    ret = "https://api.netsuite.com/#{resource_endpoint}"

    if id.present?
      ret += '/' unless ret.end_with?('/')
      ret += id.to_s
    end

    if params.present?
      uri = URI(ret)
      uri.query = params.to_query
      ret = uri.to_s
    end

    ret
  end

  def response_headers(overrides = {})
    {
      'Content-Type' => 'application/json'
    }.merge(overrides)
  end

  def netsuite_client
    LedgerSync.ledgers.netsuite.new_from_env
  end

  def netsuite_env?
    @netsuite_env ||= ENV.key?('USE_DOTENV_ADAPTOR_SECRETS')
  end

  def netsuite_records
    @netsuite_records ||= NETSUITE_RECORD_COLLECTION
  end

  def netsuite_resource_type
    record.to_s.gsub(/^netsuite_/, '')
  end

  def stub_create_for_record
    send("stub_#{netsuite_resource_type}_create")
  end

  def stub_create_request(body:, url:)
    stub_request(:post, url)
      .with(
        headers: authorized_headers
      )
      .to_return(
        status: 200,
        body: body.to_json
      )
  end

  def stub_delete_for_record
    send("stub_#{netsuite_resource_type}_delete")
  end

  def stub_delete_request(url:)
    stub_request(:delete, url)
      .with(
        headers: authorized_headers
      )
      .to_return(
        status: 204,
        body: '',
        headers: {}
      )
  end

  def stub_find_for_record(params: {})
    send("stub_#{netsuite_resource_type}_find", params)
  end

  def stub_find_request(response_body:, url:)
    stub_request(:get, url)
      .to_return(
        status: 200,
        body: (response_body.is_a?(Hash) ? response_body.to_json : response_body)
      )
  end

  def stub_search_for_record
    send("stub_#{netsuite_resource_type}_search")
  end

  def stub_update_for_record(params: {})
    send("stub_#{netsuite_resource_type}_update", params)
  end

  def stub_update_request(args = {})
    body = args.fetch(:body, '')
    url = args.fetch(:url)

    stub_request(:post, url)
      .with(
        headers: authorized_headers
      )
      .to_return(
        status: 200,
        body: body.to_json
      )
  end

  # Dynamically define helpers
  NETSUITE_RECORD_COLLECTION.all.each do |record, opts|
    record = record.gsub('/', '_')
    url_method_name = "#{record}_url"

    define_method(url_method_name) do |**keywords|
      api_record_url(
        **{
          record: record
        }.merge(keywords)
      )
    end

    define_method("stub_#{record}_create") do
      stub_create_request(
        body: opts.hash,
        url: send(url_method_name)
      )
    end

    define_method("stub_#{record}_delete") do
      stub_delete_request(
        url: send(
          url_method_name,
          id: opts.id
        )
      )
    end

    define_method("stub_#{record}_find") do |params = {}|
      stub_find_request(
        response_body: opts.hash,
        url: send(
          url_method_name,
          params: params,
          id: opts.id
        )
      )
    end

    define_method("stub_#{record}_update") do |args = {}|
      params = args.fetch(:params, {})
      body = args.fetch(:body, opts.hash)
      stub_update_request(
        body: body,
        url: send(
          url_method_name,
          params: params
        )
      )
    end
  end
end
