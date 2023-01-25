# frozen_string_literal: true

module LedgerSync
  module NetSuite
    class AdvancedIntercompanyJournalEntry
      class Searcher < Searcher
        def query_table
          "transaction WHERE type = 'AdvInterCompanyJournalEntry'"
        end
      end
    end
  end
end
