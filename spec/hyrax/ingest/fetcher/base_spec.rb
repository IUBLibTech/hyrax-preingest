require 'spec_helper'
require 'hyrax/ingest/fetch_operations/base'

RSpec.describe Hyrax::Ingest::Fetcher::Base do
  subject { described_class.new }
  it 'responds to #fetch' do
    expect(subject).to respond_to :fetch
  end
end
