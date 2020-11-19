# frozen_string_literal: true

require 'spec_helper'

support :netsuite_helpers

RSpec.describe LedgerSync::NetSuite::Client do
  include NetSuiteHelpers

  let(:api_key) { 'api_key' }
  let(:client) { netsuite_client }
  let(:initialized_client) do
    described_class.new(
      api_key: api_key
    )
  end

  subject { initialized_client }

  describe '#find' do
    it { expect(subject).to respond_to(:find) }
  end

  describe '#ledger_attributes_to_save' do
    it do
      h = {
        api_key: api_key
      }
      expect(subject.ledger_attributes_to_save).to eq(h)
    end
  end

  describe '#post' do
    it { expect(subject).to respond_to(:post) }
  end

  describe '.ledger_attributes_to_save' do
    subject { described_class.ledger_attributes_to_save }

    it { expect(subject).to eq(%i[api_key]) }
  end
end
