# frozen_string_literal: true

module LedgerSync
  module NetSuite
    class LedgerClass
      class Serializer < NetSuite::Serializer
        attribute :name
      end
    end
  end
end
