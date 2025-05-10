# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::NetSuite::IntercompanyJournalEntry, qa: true, client: :netsuite do
  let(:client) { netsuite_client }
  let(:attribute_updates) do
    {
      memo: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :intercompany_journal_entry }
  let(:resource) do
    LedgerSync::NetSuite::IntercompanyJournalEntry.new(
      memo: 'Hello World',
      trandate: Date.today.to_s,
      currency: known_currency,
      external_id: "journal_entry_test_#{test_run_id}",
      line_items: [
        LedgerSync::NetSuite::IntercompanyJournalEntryLineItem.new(
          credit: 12.20,
          account: known_expenses_account,
          memo: "QA JE Line 1 #{test_run_id}",
          subsidiary: known_subsidiary
        ),
        LedgerSync::NetSuite::IntercompanyJournalEntryLineItem.new(
          debit: 12.20,
          account: known_checking_account,
          memo: "QA JE Line 2 #{test_run_id}",
          subsidiary: known_subsidiary_other
        )
      ]
    )
  end

  it_behaves_like 'a full netsuite resource'
end
