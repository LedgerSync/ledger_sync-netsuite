# frozen_string_literal: true

require_relative '../reference/serializer'

module LedgerSync
  module NetSuite
    class JournalEntryLineItem
      class Serializer < NetSuite::Serializer
        attribute :line
        attribute :entitytype
        attribute :credit
        attribute :debit
        attribute :memo
        references_one :account,
                       serializer: Reference::Serializer
      end
    end
  end
end
