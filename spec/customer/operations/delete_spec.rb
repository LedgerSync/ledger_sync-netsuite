# frozen_string_literal: true

require 'spec_helper'

core_support :operation_shared_examples
support :netsuite_helpers

RSpec.describe LedgerSync::NetSuite::Customer::Operations::Delete do
  include NetSuiteHelpers

  let(:resource) { create(:netsuite_customer, ledger_id: 1137) }
  let(:client) { netsuite_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_customer_delete
end
