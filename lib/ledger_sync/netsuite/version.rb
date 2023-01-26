# frozen_string_literal: true

# :nocov:
module LedgerSync
  module NetSuite
    VERSION = '0.4.0'

    def self.version
      if ENV['PRE_RELEASE']
        "#{VERSION}.pre.#{ENV.fetch('GITHUB_RUN_NUMBER', nil)}"
      else
        VERSION
      end
    end
  end
end
# :nocov:
