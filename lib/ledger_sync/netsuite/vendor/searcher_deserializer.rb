# frozen_string_literal: true

module LedgerSync
  module NetSuite
    class Vendor
      class SearcherDeserializer < NetSuite::Deserializer
        id

        attribute :email

        attribute :company_name,
                  hash_attribute: :companyname

        attribute :phone_number,
                  hash_attribute: :phone

        attribute :last_modified_date,
                  hash_attribute: :lastmodifieddate
      end
    end
  end
end
