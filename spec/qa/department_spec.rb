# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::NetSuite::Department, qa: true, client: :netsuite do
  let(:client) { netsuite_client }
  let(:attribute_updates) do
    {
      name: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :department }
  let(:resource) do
    LedgerSync::NetSuite::Department.new(
      external_id: "department_#{test_run_id}",
      name: "Test Department #{test_run_id}"
    )
  end

  it_behaves_like 'a full netsuite resource'
  it_behaves_like 'a searcher'
end
