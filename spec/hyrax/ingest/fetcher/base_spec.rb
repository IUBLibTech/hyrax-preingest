require 'spec_helper'
require 'hyrax/ingest/fetcher/base'

RSpec.describe Hyrax::Ingest::Fetcher::Base do
  subject { described_class.new }
  it 'responds to #fetch' do
    expect(subject).to respond_to :fetch
  end

  it 'responds to .validate_options' do
    expect(described_class).to respond_to :validate_options
  end
end
