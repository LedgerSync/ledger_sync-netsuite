# frozen_string_literal: true

require 'oauth2'

module LedgerSync
  module NetSuite
    class Client
      include Ledgers::Client::Mixin

      HEADERS = {
        # 'Accept' => 'application/schema+json'
      }.freeze

      WRITE_HEADERS = {
        'Accept' => '*/*',
        'Content-Type' => 'application/json',
        'prefer' => 'transient'
      }.freeze

      attr_reader :account_id,
                  :consumer_key,
                  :consumer_secret,
                  :token_id,
                  :token_secret

      def initialize(args = {})
        @account_id = args.fetch(:account_id)
        @consumer_key = args.fetch(:consumer_key)
        @consumer_secret = args.fetch(:consumer_secret)
        @token_id = args.fetch(:token_id)
        @token_secret = args.fetch(:token_secret)

        super()
      end

      def account_id_for_oauth
        account_id.gsub('-', '_').upcase
      end

      def account_id_for_url
        account_id.gsub('_', '-').downcase
      end

      def api_base_url
        @api_base_url ||= URI::HTTPS.build(
          host: api_host,
          path: '/services/rest/record/v1'
        ).to_s
      rescue URI::InvalidComponentError => e
        raise LedgerSync::Error::LedgerError::ConfigurationError.new(client: self, message: e.message)
      end

      def api_host
        @api_host ||= "#{account_id_for_url}.suitetalk.api.netsuite.com"
      end

      def delete(**keywords)
        request(keywords.merge(method: :delete))
      end

      def get(**keywords)
        request(keywords.merge(method: :get))
      end

      def ledger_resource_path(args = {})
        resource = args.fetch(:resource, nil)
        params   = args.fetch(:params, {})

        ret = self.class.ledger_resource_type_for(resource_class: resource.class)
        ret += "/#{resource.ledger_id}" if resource.ledger_id.present? && args.fetch(:id, true)
        Util::URLHelpers.merge_params_in_path(
          path: ret,
          params: params
        )
      end

      def metadata_for(record:)
        Record::Metadata.new(
          client: self,
          record: record
        )
      end

      def patch(headers: {}, **keywords)
        request(
          keywords.merge(
            headers: WRITE_HEADERS.merge(headers),
            method: :patch
          )
        )
      end

      def post(headers: {}, **keywords)
        request(
          keywords.merge(
            headers: WRITE_HEADERS.merge(headers),
            method: :post
          )
        )
      end

      def self.ledger_attributes_to_save
        %i[]
      end

      def self.new_from_env(**override)
        new(
          {
            account_id: ENV.fetch('NETSUITE_ACCOUNT_ID', nil),
            consumer_key: ENV.fetch('NETSUITE_CONSUMER_KEY', nil),
            consumer_secret: ENV.fetch('NETSUITE_CONSUMER_SECRET', nil),
            token_id: ENV.fetch('NETSUITE_TOKEN_ID', nil),
            token_secret: ENV.fetch('NETSUITE_TOKEN_SECRET', nil)
          }.merge(override)
        )
      end

      def url_for(resource:)
        DashboardURLHelper.new(
          resource: resource,
          base_url: "https://#{account_id_for_url}.app.netsuite.com"
        ).url
      end

      def self.ledger_resource_type_overrides
        {
          CustomerDeposit => 'customerdeposit',
          LedgerClass => 'classification',
          JournalEntry => 'journalEntry'
        }
      end

      private

      def new_token(args = {})
        Token.new(
          args.merge(
            consumer_key: consumer_key,
            consumer_secret: consumer_secret,
            token_id: token_id,
            token_secret: token_secret
          )
        )
      end

      def request(args = {})
        body        = args.fetch(:body, nil)
        headers     = args.fetch(:headers, {})
        method      = args.fetch(:method)
        path        = args.fetch(:path, nil)
        request_url = args.fetch(:request_url, url_from_path(path: path))

        token = new_token(
          body: body,
          method: method,
          url: request_url
        )

        request = LedgerSync::Ledgers::Request.new(
          body: body,
          headers: headers
            .merge(HEADERS)
            .merge(
              token.headers(
                realm: account_id_for_oauth
              )
            )
            .merge(
              'Host' => api_host
            ),
          method: method,
          url: request_url
        )

        request.perform
      end

      def url_from_path(path:)
        request_url = api_base_url
        request_url += '/' unless path.to_s.start_with?('/')
        request_url + path.to_s
      end
    end
  end
end
