# frozen_string_literal: true

# :nocov:
module LedgerSync
  module NetSuite
    VERSION = '0.1.1'

    def self.version(args = {})
      pre = ENV['PRE_RELEASE'] || args.fetch(:pre, false)

      return VERSION unless pre

      "#{VERSION}.pre.#{ENV['TRAVIS_BUILD_NUMBER']}"
    end
  end
end
# :nocov:
