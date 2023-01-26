# frozen_string_literal: true

core_qa_support :ledger_helpers
qa_support :netsuite_shared_examples

module QA
  module NetSuiteHelpers
    include LedgerSync::Test::QA::LedgerHelpers

    def client_class
      LedgerSync::NetSuite::Client
    end

    def existing_customer_resource
      LedgerSync::NetSuite::Customer.new(
        ledger_id: 316,
        companyName: "QA Customer #{test_run_id}"
      )
    end

    def netsuite_client
      @netsuite_client ||= client_class.new_from_env
    end

    # Known Entities

    def known_currency
      LedgerSync::NetSuite::Currency.new(
        ledger_id: ENV.fetch('NETSUITE_KNOWN_CURRENCY_ID')
      )
    end

    def known_subsidiary
      LedgerSync::NetSuite::Subsidiary.new(
        ledger_id: ENV.fetch('NETSUITE_KNOWN_SUBSIDIARY_ID'),
        name: "QA Subsidary #{test_run_id}"
      )
    end

    def known_subsidiary_other
      LedgerSync::NetSuite::Subsidiary.new(
        ledger_id: ENV.fetch('NETSUITE_KNOWN_SUBSIDIARY_OTHER_ID'),
        name: "QA Subsidary #{test_run_id}"
      )
    end

    def known_expenses_account
      LedgerSync::NetSuite::Account.new(
        ledger_id: ENV.fetch('NETSUITE_KNOWN_EXPENSES_ACCOUNT_ID')
      )
    end

    def known_checking_account
      LedgerSync::NetSuite::Account.new(
        ledger_id: ENV.fetch('NETSUITE_KNOWN_CHECKING_ACCOUNT_ID')
      )
    end

    def known_checking_account_in_other_subsidary
      LedgerSync::NetSuite::Account.new(
        ledger_id: ENV.fetch('NETSUITE_KNOWN_CHECKING_ACCOUNT_IN_OTHER_SUBSIDIARY_ID')
      )
    end

    def known_receivables_account
      LedgerSync::NetSuite::Account.new(
        ledger_id: ENV.fetch('NETSUITE_KNOWN_RECEIVABLES_ACCOUNT_ID')
      )
    end

    def known_account
      LedgerSync::NetSuite::Account.new(
        ledger_id: ENV.fetch('NETSUITE_KNOWN_RECEIVABLES_ACCOUNT_ID')
      )
    end

    def known_vendor
      LedgerSync::NetSuite::Vendor.new(
        ledger_id: ENV.fetch('NETSUITE_KNOWN_VENDOR_ID')
      )
    end
  end
end

RSpec.configure do |config|
  config.include QA::NetSuiteHelpers, qa: true
end
