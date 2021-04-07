# frozen_string_literal: true

require 'spec_helper'

support 'netsuite_shared_examples'

RSpec.describe LedgerSync::NetSuite::CustomerDeposit::Searcher do
  include NetSuiteHelpers

  it_behaves_like 'a netsuite searcher'
end
