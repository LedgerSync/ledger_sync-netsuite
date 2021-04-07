# frozen_string_literal: true

module LedgerSync
  module NetSuite
    class Subsidiary
      class Serializer < NetSuite::Serializer
        attribute :name

        attribute :state
      end
    end
  end
end
