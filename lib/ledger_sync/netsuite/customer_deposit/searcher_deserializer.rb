# frozen_string_literal: true

module LedgerSync
  module NetSuite
    class CustomerDeposit
      class SearcherDeserializer < NetSuite::Deserializer
        id

        attribute :payment
        attribute :undepFunds
      end
    end
  end
end
