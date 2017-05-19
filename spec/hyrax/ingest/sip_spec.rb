require 'spec_helper'
require 'hyrax/ingest/sip.rb'

RSpec.describe Hyrax::Ingest::SIP do
  describe '.new' do
    context 'when given an invalid path' do
      it 'raises an InvalidSIPPath error' do
        expect { described_class.new('path/to/nothing') }.to raise_error Hyrax::Ingest::Errors::InvalidSIPPath
      end
    end
  end
end
