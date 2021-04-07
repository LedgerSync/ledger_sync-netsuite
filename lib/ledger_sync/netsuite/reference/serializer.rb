# frozen_string_literal: true

module LedgerSync
  module NetSuite
    class Reference
      class Serializer < NetSuite::Serializer
        attribute :id, resource_attribute: :ledger_id
      end
    end
  end
end
