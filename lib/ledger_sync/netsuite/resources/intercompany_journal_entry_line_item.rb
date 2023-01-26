# frozen_string_literal: true

require_relative 'account'
require_relative 'customer'
require_relative 'department'
require_relative 'ledger_class'
require_relative 'vendor'
require_relative 'subsidiary'

module LedgerSync
  module NetSuite
    class IntercompanyJournalEntryLineItem < NetSuite::Resource
      references_one :account, to: Account
      references_one :subsidiary, to: Subsidiary
      references_one :entity, to: [Customer, Vendor]
      references_one :ledger_class, to: LedgerClass
      attribute :line, type: Type::Integer
      attribute :credit, type: Type::Float
      attribute :debit, type: Type::Float
      attribute :entitytype, type: Type::String
      attribute :memo, type: Type::String

      def name
        description
      end
    end
  end
end
