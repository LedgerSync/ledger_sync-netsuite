# frozen_string_literal: true

module LedgerSync
  module NetSuite
    class Location
      class Deserializer < NetSuite::Deserializer
        id

        attribute :name
      end
    end
  end
end
