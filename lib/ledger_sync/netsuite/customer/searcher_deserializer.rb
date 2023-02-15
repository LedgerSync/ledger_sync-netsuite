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
        attribute :last_modified_date,
                  hash_attribute: :lastmodifieddate
      end
    end
  end
end
