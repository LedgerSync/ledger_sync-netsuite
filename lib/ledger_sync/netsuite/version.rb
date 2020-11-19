# frozen_string_literal: true

# :nocov:
module LedgerSync
  module NetSuite
    VERSION = '0.1.1'

    def self.version(args = {})
      pre = args.fetch(:pre, false)

      if !pre && (!ENV['TRAVIS'] || ENV.fetch('TRAVIS_TAG', '') != '')
        VERSION
      else
        "#{VERSION}.pre.#{ENV['TRAVIS_BUILD_NUMBER']}"
      end
    end
  end
end
# :nocov:
