# frozen_string_literal: true

core_qa_support :ledger_helpers
qa_support :netsuite_shared_examples

module QA
  module NetSuiteHelpers
    include LedgerSync::Test::QA::LedgerHelpers

    def client_class
      LedgerSync::NetSuite::Client
    end

    def existing_account_resource
      LedgerSync::NetSuite::Account.new(
        ledger_id: 220
      )
    end

    def existing_customer_resource
      LedgerSync::NetSuite::Customer.new(
        ledger_id: 316,
        companyName: "QA Customer #{test_run_id}"
      )
    end

    def existing_netsuite_subsidiary_resource
      LedgerSync::NetSuite::Subsidiary.new(
        ledger_id: 2,
        name: "QA Subsidary #{test_run_id}"
      )
    end

    def netsuite_client
      @netsuite_client ||= client_class.new_from_env
    end
  end
end

RSpec.configure do |config|
  config.include QA::NetSuiteHelpers, qa: true
end
