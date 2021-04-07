# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::NetSuite::Check, qa: true, client: :netsuite do
  let(:client) { netsuite_client }
  let(:attribute_updates) do
    {
      memo: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :check }
  let(:resource) do
    LedgerSync::NetSuite::Check.new(
      memo: 'Hello World',
      trandate: Date.today.to_s,
      entity: known_vendor,
      account: known_checking_account,
      department: nil,
      currency: known_currency,
      external_id: "external_id_test_#{test_run_id}",
      line_items: [
        LedgerSync::NetSuite::CheckLineItem.new(
          amount: 12.20,
          account: known_expenses_account,
          department: nil
        )
      ]
    )
  end

  it_behaves_like 'a full netsuite resource'
  it_behaves_like 'a searcher'
end
