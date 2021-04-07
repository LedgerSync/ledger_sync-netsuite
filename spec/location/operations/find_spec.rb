# frozen_string_literal: true

require 'spec_helper'

core_support :operation_shared_examples
support :netsuite_helpers

RSpec.describe LedgerSync::NetSuite::Location::Operations::Find do
  it_behaves_like 'a netsuite operation'
end
