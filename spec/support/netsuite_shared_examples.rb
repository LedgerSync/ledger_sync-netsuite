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
    when :delete
      resource.ledger_id = netsuite_records.send(record).id
    when :find
      resource.ledger_id = netsuite_records.send(record).id
    when :update
      resource.ledger_id = netsuite_records.send(record).id
    end
  end

  it_behaves_like 'a valid operation'

  context do
    before do
      case described_class.operation_method
      when :create
        stub_create_for_record
      when :delete
        resource.ledger_id = netsuite_records.send(record).id
        stub_delete_for_record
      when :find
        resource.ledger_id = netsuite_records.send(record).id
        stub_find_for_record
      when :update
        resource.ledger_id = netsuite_records.send(record).id
        stub_update_for_record
      end
    end

    it_behaves_like 'a successful operation'
  end
end
