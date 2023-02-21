# frozen_string_literal: true

require_relative 'subsidiary'

module LedgerSync
  module NetSuite
    class Customer < NetSuite::Resource
      attribute :email, type: LedgerSync::Type::String
      attribute :companyName, type: LedgerSync::Type::String
      attribute :firstName, type: LedgerSync::Type::String
      attribute :lastName, type: LedgerSync::Type::String
      attribute :phone, type: LedgerSync::Type::String
      attribute :lastModifiedDate, type: Type::String

      references_one :subsidiary, to: Subsidiary
    end
  end
end
