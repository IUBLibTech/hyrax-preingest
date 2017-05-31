require 'spec_helper'
require 'hyrax/ingest/fetcher'
require 'hyrax/ingest/sip'

RSpec.describe Hyrax::Ingest::Fetcher do
  describe '.factory' do
    let(:sip) { Hyrax::Ingest::SIP.new(path: "#{fixture_path}/sip_examples/fits_example_1.xml") }

    context 'when given params that specify fetching from an xml file by name' do
      let(:params) { {xml_file: 'fits_example_1.xml' } }
      subject { described_class.factory(sip: sip, params: params) }
      it 'returns an instance of Hyrax::Ingest::Fetcher::FromXML' do
        expect(subject).to be_a Hyrax::Ingest::Fetcher::FromXML
      end
    end

    context 'when given params that are too ambiguous to determine the appropriate mapper' do
      subject { described_class.factory(sip: sip, params: {}) }
      it 'raises an AmbiguousMappingOptions error' do
        expect { subject }.to raise_error Hyrax::Ingest::Errors::AmbiguousMappingOptions
      end
    end
  end
end
