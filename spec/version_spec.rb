# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::NetSuite do
  it { expect(described_class).to respond_to(:version) }
  it { expect(described_class.version(pre: true)).to include('.pre.') }
end
