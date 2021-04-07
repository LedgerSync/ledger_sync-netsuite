# frozen_string_literal: true

require_relative '../reference/serializer'

module LedgerSync
  module NetSuite
    class Customer
      class Serializer < NetSuite::Serializer
        attribute :companyName

        attribute :externalId,
                  resource_attribute: :external_id

        attribute :email

        attribute :phone

        attribute :firstName

        attribute :lastName

        references_one :subsidiary,
                       serializer: Reference::Serializer
      end
    end
  end
end
