# frozen_string_literal: true

require_relative 'item'
require_relative 'ledger_class'

module LedgerSync
  module NetSuite
    class InvoiceLineItem < NetSuite::Resource
      references_one :item, to: Item
      references_one :ledger_class, to: LedgerClass
      attribute :amount, type: Type::Integer
      attribute :description, type: Type::String

      def name
        description
      end
    end
  end
end
