# frozen_string_literal: true

module LedgerSync
  module NetSuite
    class LedgerClass
      class SearcherDeserializer < NetSuite::Deserializer
        id

        attribute :name

        attribute :active,
                  hash_attribute: :isinactive,
                  type: Type::DeserializerActiveType.new
      end
    end
  end
end
