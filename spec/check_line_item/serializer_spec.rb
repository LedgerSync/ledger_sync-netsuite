# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::NetSuite::CheckLineItem::Serializer do
  let(:account) do
    LedgerSync::NetSuite::Account.new(
      ledger_id: 'account_ledger_id'
    )
  end

  let(:department) do
    LedgerSync::NetSuite::Department.new(
      ledger_id: 'department_ledger_id'
    )
  end

  let(:ledger_class) do
    LedgerSync::NetSuite::LedgerClass.new(
      ledger_id: 'class_ledger_id'
    )
  end

  let(:resource) do
    LedgerSync::NetSuite::CheckLineItem.new(
      amount: 150.0,
      memo: 'This is memo',
      account: account,
      department: department,
      ledger_class: ledger_class
    )
  end

  let(:h) do
    {
      'amount' => 150.0,
      'memo' => 'This is memo',
      'account' => {
        'id' => 'account_ledger_id'
      },
      'department' => {
        'id' => 'department_ledger_id'
      },
      'class' => {
        'id' => 'class_ledger_id'
      }
    }
  end

  describe '#serialize' do
    it do
      serializer = described_class.new
      expect(serializer.serialize(resource: resource)).to eq(h)
    end
  end
end
