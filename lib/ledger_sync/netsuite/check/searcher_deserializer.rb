# frozen_string_literal: true

module LedgerSync
  module NetSuite
    class Check
      class SearcherDeserializer < NetSuite::Deserializer
        id

        attribute :trandate
        attribute :memo
      end
    end
  end
end
