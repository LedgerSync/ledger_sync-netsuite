# frozen_string_literal: true

module LedgerSync
  module NetSuite
    class Error < LedgerSync::Error
      class SubsidiariesNotEnabled < self
        def initialize(message: nil)
          message ||= 'Subsidiaries are not enabled on this account'

          super
        end
      end
    end
  end
end
