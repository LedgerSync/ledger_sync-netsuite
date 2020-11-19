# frozen_string_literal: true

module LedgerSync
  module NetSuite
    class Location
      class Serializer < NetSuite::Serializer
        attribute :name
      end
    end
  end
end
