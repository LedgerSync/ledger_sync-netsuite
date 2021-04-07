# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::NetSuite::LedgerClass, qa: true, client: :netsuite do
  let(:client) { netsuite_client }
  let(:attribute_updates) do
    {
      name: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :classification }
  let(:resource) do
    LedgerSync::NetSuite::LedgerClass.new(
      external_id: "ledger_class_#{test_run_id}",
      name: "Test Ledger Class #{test_run_id}"
    )
  end

  it_behaves_like 'a full netsuite resource'
  it_behaves_like 'a searcher'
end
