# frozen_string_literal: true

require_relative '../reference/serializer'

module LedgerSync
  module NetSuite
    class IntercompanyJournalEntryLineItem
      class Serializer < NetSuite::Serializer
        attribute :entitytype
        attribute :credit
        attribute :debit
        attribute :memo
        references_one :entity,
                       serializer: Reference::Serializer
        references_one :class,
                       resource_attribute: :ledger_class,
                       serializer: Reference::Serializer
        references_one :account,
                       serializer: Reference::Serializer
        references_one :subsidiary,
                       serializer: Reference::Serializer
      end
    end
  end
end
