# frozen_string_literal: true

module LedgerSync
  module NetSuite
    class IntercompanyJournalEntry
      class Searcher < Searcher
        def query_table
          "transaction"
        end
      end
    end
  end
end
