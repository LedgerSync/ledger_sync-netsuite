# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::NetSuite::Currency, qa: true, client: :netsuite do
  let(:client) { netsuite_client }
  let(:attribute_updates) do
    {
      name: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :currency }
  let(:currency_iso_code) { ENV.fetch('NETSUITE_KNOWN_SUBSIDIARY_ID')}
  let(:resource) do
    FactoryBot.create(:netsuite_currency, symbol: currency_iso_code)
  end

  # Delete stopped working as of 2020-04-07
  # # Delete the test currency if it exists
  # before do
  #   delete_result_for(
  #     client: client,
  #     resource: resource
  #   )
  # end

  # it_behaves_like 'a full netsuite resource'

  it do
    result = find_result_for(
      client: client,
      resource: resource
    )

    expect(result).to be_success
  end
end
