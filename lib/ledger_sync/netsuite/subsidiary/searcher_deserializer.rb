# frozen_string_literal: true

module LedgerSync
  module NetSuite
    class Subsidiary
      class SearcherDeserializer < NetSuite::Deserializer
        id

        attribute :name
      end
    end
  end
end
