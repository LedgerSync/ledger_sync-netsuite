# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::NetSuite::Account::SearcherDeserializer do
  let(:accountsearchdisplayname) { 'test-accountsearchdisplayname' }
  let(:acctnumber) { '654654' }
  let(:accttype) { 'COGS' }
  let(:isinactive) { 'F' }
  let(:id) { 'acct_1234' }

  let(:h) do
    {
      'accountsearchdisplayname' => accountsearchdisplayname,
      'acctnumber' => acctnumber,
      'accttype' => accttype,
      'isinactive' => isinactive,
      'id' => id
    }
  end

  describe '#deserialize' do
    let(:serializer) { described_class.new }
    let(:deserialized_resource) do
      serializer.deserialize(hash: h, resource: LedgerSync::NetSuite::Account.new)
    end

    it do
      expect(deserialized_resource.ledger_id).to eq(id)
      expect(deserialized_resource.name).to eq(accountsearchdisplayname)
      expect(deserialized_resource.number).to eq(acctnumber)
      expect(deserialized_resource.account_type).to eq('cost_of_goods_sold')
      expect(deserialized_resource.active).to be_truthy
    end
  end
end
