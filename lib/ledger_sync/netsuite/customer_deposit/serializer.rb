# frozen_string_literal: true

require_relative '../reference/serializer'

module LedgerSync
  module NetSuite
    class CustomerDeposit
      class Serializer < NetSuite::Serializer
        references_one :account,
                       serializer: Reference::Serializer

        references_one :customer,
                       serializer: Reference::Serializer

        attribute :externalId,
                  resource_attribute: :external_id

        attribute :payment
        attribute :undepFunds
      end
    end
  end
end
