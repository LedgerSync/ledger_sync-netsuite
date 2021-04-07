# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::NetSuite::Customer, qa: true, client: :netsuite do
  let(:client) { netsuite_client }
  let(:attribute_updates) do
    {
      companyName: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :customer }
  let(:resource) do
    described_class.new(
      email: "#{test_run_id}@example.com",
      external_id: "customer_#{test_run_id}",
      companyName: "Test Customer #{test_run_id}",
      phone: '1234567890',
      subsidiary: known_subsidiary
    )
  end

  it_behaves_like 'a full netsuite resource'
  it_behaves_like 'a searcher'
end
