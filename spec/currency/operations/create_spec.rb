# frozen_string_literal: true

require 'spec_helper'

support 'netsuite_shared_examples'

RSpec.describe LedgerSync::NetSuite::Currency::Operations::Create do
  it_behaves_like 'a netsuite operation'
end
