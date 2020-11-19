# frozen_string_literal: true

core_qa_support :ledger_helpers
qa_support :netsuite_shared_examples

module QA
  module NetSuiteHelpers
    include LedgerSync::Test::QA::LedgerHelpers

    def client_class
      LedgerSync::NetSuite::Client
    end

    def netsuite_client
      @netsuite_client ||= client_class.new_from_env
    end
  end
end

RSpec.configure do |config|
  config.include QA::NetSuiteHelpers, qa: true
end
