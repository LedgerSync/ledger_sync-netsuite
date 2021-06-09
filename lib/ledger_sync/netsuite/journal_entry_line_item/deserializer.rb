# frozen_string_literal: true

require_relative '../account/deserializer'
require_relative '../ledger_class/deserializer'

module LedgerSync
  module NetSuite
    class JournalEntryLineItem
      class Deserializer < NetSuite::Deserializer
        attribute :line
        attribute :entitytype
        attribute :credit
        attribute :debit
        attribute :memo
        attribute :entity,
                  type: Type::DeserializerEntityType.new
        references_one :ledger_class,
                       hash_attribute: :class,
                       deserializer: LedgerClass::Deserializer
        references_one :account
      end
    end
  end
end
