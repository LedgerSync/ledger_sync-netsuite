# frozen_string_literal: true

core_qa_support :shared_examples

RSpec.shared_examples 'a full netsuite resource' do
  it_behaves_like 'a create', delete: true
  it_behaves_like 'a find', delete: true
  it_behaves_like 'an update', delete: true
end
