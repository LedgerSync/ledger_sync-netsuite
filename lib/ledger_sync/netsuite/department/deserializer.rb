# frozen_string_literal: true

module LedgerSync
  module NetSuite
    class Department
      class Deserializer < NetSuite::Deserializer
        id

        attribute :name
      end
    end
  end
end
