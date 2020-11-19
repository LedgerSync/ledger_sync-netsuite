# frozen_string_literal: true

require_relative 'client'

args = {
  base_module: LedgerSync::NetSuite,
  root_path: 'ledger_sync/netsuite'
}

LedgerSync.register_ledger(:netsuite, args) do |config|
  config.name = 'NetSuite REST'
end
