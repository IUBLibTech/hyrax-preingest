require 'hyrax/ingest/attribute_ingester.rb'

RSpec.describe Hyrax::Ingest::SIP do

  describe '.new' do
    context 'when given an invalid path' do
      subject { described_class.new(false) }
      it 'raises an InvalidSIPPath error' do
        
      end
    end

  describe '#files' do
    context 'when SIP is a single file' do
      subject { described_class.new() }
      it 'returns an array containing only that one file' do

      end
    end
  end
end
