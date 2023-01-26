# frozen_string_literal: true

require_relative 'currency'
require_relative 'subsidiary'
require_relative 'intercompany_journal_entry_line_item'

module LedgerSync
  module NetSuite
    class IntercompanyJournalEntry < NetSuite::Resource
      attribute :memo, type: Type::String
      attribute :trandate, type: Type::Date
      attribute :tranId, type: Type::String

      references_one :currency, to: Currency
      references_one :subsidiary, to: Subsidiary

      references_many :line_items, to: JournalEntryLineItem

      def name
        "JournalEntry: #{transaction_date}"
      end
    end
  end
end
