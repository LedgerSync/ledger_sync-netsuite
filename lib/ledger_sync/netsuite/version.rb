# frozen_string_literal: true

# :nocov:
module LedgerSync
  module NetSuite
    VERSION = '0.3.6'

    def self.version
      if ENV['PRE_RELEASE']
        "#{VERSION}.pre.#{ENV['GITHUB_RUN_NUMBER']}"
      else
        VERSION
      end
    end
  end
end
# :nocov:
