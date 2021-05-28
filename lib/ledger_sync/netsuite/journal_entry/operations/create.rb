# frozen_string_literal: true

module LedgerSync
  module NetSuite
    class JournalEntry
      module Operations
        class Create < NetSuite::Operation::Create
          class Contract < LedgerSync::Ledgers::Contract
            params do
              required(:external_id).filled(:string)
              required(:ledger_id).value(:nil)
              required(:memo).maybe(:string)
              required(:trandate).maybe(:date?)
              required(:tranId).maybe(:string)
              required(:currency).maybe(:hash, Types::Reference)
              required(:subsidiary).maybe(:hash, Types::Reference)
              required(:ledger_class).maybe(:hash, Types::Reference)
              required(:line_items).array(Types::Reference)
            end
          end
        end
      end
    end
  end
end
