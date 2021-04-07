# frozen_string_literal: true

module LedgerSync
  module NetSuite
    class Department
      module Operations
        class Update < NetSuite::Operation::Update
          class Contract < LedgerSync::Ledgers::Contract
            params do
              required(:external_id).maybe(:string)
              required(:ledger_id).filled(:string)
              required(:name).filled(:string)
              optional(:active).maybe(:bool?)
              optional(:sub_department).maybe(:bool?)
              optional(:fully_qualified_name).maybe(:string)
              optional(:parent).maybe(:hash, Types::Reference)
            end
          end
        end
      end
    end
  end
end
