# frozen_string_literal: true

# require client-specific types
Gem.find_files('ledger_sync/netsuite/type/**/*.rb').each { |path| require path }

module LedgerSync
  module NetSuite
    class Serializer < LedgerSync::Serializer
    end
  end
end
