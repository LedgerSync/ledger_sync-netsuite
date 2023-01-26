# frozen_string_literal: true

module LedgerSync
  module NetSuite
    class JournalEntry
      class Searcher < Searcher
        def query_table
          "transaction WHERE type = 'Check'"
        end
      end
    end
  end
end
