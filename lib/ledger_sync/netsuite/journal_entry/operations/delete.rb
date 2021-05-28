# frozen_string_literal: true

module LedgerSync
  module NetSuite
    class JournalEntry
      module Operations
        class Delete < NetSuite::Operation::Delete
          class Contract < LedgerSync::Ledgers::Contract
            params do
              required(:external_id).maybe(:string)
              required(:ledger_id).filled(:string)
              optional(:memo).maybe(:string)
              optional(:trandate).maybe(:date?)
              optional(:tranId).maybe(:string)
              optional(:currency).maybe(:hash, Types::Reference)
              optional(:subsidiary).maybe(:hash, Types::Reference)
              required(:ledger_class).maybe(:hash, Types::Reference)
              optional(:line_items).array(Types::Reference)
            end
          end
        end
      end
    end
  end
end
