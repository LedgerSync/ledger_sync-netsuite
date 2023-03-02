# frozen_string_literal: true

core_support :operation_shared_examples
support :netsuite_helpers

RSpec.shared_examples 'a netsuite operation' do
  include NetSuiteHelpers

  let(:resource) { FactoryBot.create("#{client.class.config.root_key}_#{record}") } unless method_defined?(:resource)
  let(:client) { netsuite_client } unless method_defined?(:client)
  unless method_defined?(:record)
    let(:record) do
      described_class.inferred_resource_class.resource_type.to_s
    end
  end
  let(:request_params) { described_class.new(client: client, resource: nil).request_params }

  before do
    case described_class.operation_method
    when :create
      resource.ledger_id = nil
    when :delete, :find, :update
      resource.ledger_id = netsuite_records.send(record).hash['id']
    end
  end

  it_behaves_like 'a valid operation'

  context do
    before do
      case described_class.operation_method
      when :create
        stub_create_for_record
        params = {}
        find_operation_class = client.class.operation_class_for(
          method: :find,
          resource_class: resource.class
        )
        params[:expandSubResources] = true if find_operation_class.expand_sub_resources?
        stub_find_for_record(params: params)
      when :delete
        resource.ledger_id = netsuite_records.send(record).hash['id']
        stub_delete_for_record
      when :find
        resource.ledger_id = netsuite_records.send(record).hash['id']
        params = {}
        find_operation_class = client.class.operation_class_for(
          method: :find,
          resource_class: resource.class
        )
        params[:expandSubResources] = true if find_operation_class.expand_sub_resources?
        stub_find_for_record(params: params)
      when :update
        resource.ledger_id = netsuite_records.send(record).hash['id']
        params = {}
        find_operation_class = client.class.operation_class_for(
          method: :find,
          resource_class: resource.class
        )
        params[:expandSubResources] = true if find_operation_class.expand_sub_resources?
        stub_find_for_record(params: params)
        stub_update_for_record(params: request_params)
      end
    end

    it_behaves_like 'a successful operation'
  end
end

RSpec.shared_examples 'a netsuite searcher' do
  include NetSuiteHelpers

  let(:client) { netsuite_client } unless method_defined?(:client)
  let(:resource_class) { described_class.inferred_resource_class } unless method_defined?(:resource_class)
  let(:query) { '' }
  unless method_defined?(:record)
    let(:record) do
      resource_class.resource_type.to_s
    end
  end
  let(:input) do
    {
      client: client,
      query: query
    }
  end
  let(:searcher) { described_class.new(**input) }

  describe '#query_string' do
    subject { searcher.query_string }

    it { expect(subject).to end_with("FROM #{searcher.query_table}") }

    context 'when query is present' do
      let(:query) { 'asdf' }

      it { expect(subject).to end_with("FROM #{searcher.query_table} WHERE asdf") }
    end
  end

  context 'when request is made' do

    before do
      stub_search_for_record
    end

    describe '#resources' do
      subject { searcher.search.resources }

      it { expect(subject.count).to eq(2) }
      it { expect(subject.first).to be_a(resource_class) }
    end

    describe '#search' do
      subject { searcher.search }

      it { expect(subject).to be_success }
      it { expect(subject).to be_a(LedgerSync::SearchResult::Success) }
    end
  end
end
