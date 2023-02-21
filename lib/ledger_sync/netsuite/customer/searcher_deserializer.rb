# frozen_string_literal: true

module LedgerSync
  module NetSuite
    class Customer
      class SearcherDeserializer < NetSuite::Deserializer
        id

        attribute :email
        attribute :companyName,
                  hash_attribute: :companyname
        attribute :phone
        attribute :lastModifiedDate,
                  hash_attribute: :lastmodifieddate
      end
    end
  end
end
