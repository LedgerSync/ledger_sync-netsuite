# frozen_string_literal: true

require 'spec_helper'

support :netsuite_helpers

RSpec.describe LedgerSync::NetSuite::Client do
  include NetSuiteHelpers

  let(:account_id) { 'account_id' }
  let(:api_version) { '2016_2' }
  let(:consumer_key) { 'consumer_key' }
  let(:consumer_secret) { 'consumer_secret' }
  let(:token_id) { 'token_id' }
  let(:token_secret) { 'token_secret' }
  let(:client) { netsuite_client }

  subject do
    described_class.new(
      account_id: account_id,
      consumer_key: consumer_key,
      consumer_secret: consumer_secret,
      token_id: token_id,
      token_secret: token_secret
    )
  end

  context 'when preventing local urls in api_base_url' do
    let(:api_base_url) { subject.api_base_url }

    context 'when account_id is localhost/#' do
      let(:account_id) { 'localhost/#' }

      it 'does not permit localhost/# for account_id' do
        expect { api_base_url }.to raise_error(LedgerSync::Error::LedgerError::ConfigurationError)
      end
    end

    context 'when account_id is 127.0.0.1/#' do
      let(:account_id) { '127.0.0.1/#' }

      it 'does not permit 127.0.0.1/# for account_id' do
        expect { api_base_url }.to raise_error(LedgerSync::Error::LedgerError::ConfigurationError)
      end
    end
  end
end
