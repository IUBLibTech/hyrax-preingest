require 'hyrax_helper'
require 'hyrax/ingest/fetcher/xml_file'
require 'hyrax/ingest/reporting'

RSpec.describe Hyrax::Ingest::Fetcher::XMLFile do
  let(:sip) { Hyrax::Ingest::SIP.new(path: "#{fixture_path}/sip_examples/40000000054496_20160213-082528") }

  describe '#fetch' do
    context 'when :filename option is a string (not a regex) and xpath points to a value in the xml' do
      let(:options) { {filename: 'MDPI_40000000542243_pod.xml', xpath: '/object/details/title' } }

      let(:fetcher_1) { described_class.new(options) }
      let(:fetcher_2) { described_class.new(options) }

      before do
        fetcher_1.sip = sip
        fetcher_2.sip = sip
      end

      it 'returns the value from the XML pointed to by the xpath' do
        expect(fetcher_1.fetch).to eq ['"Brain" Cam 1 Tape 1']
      end

      it 'can fetch same metadata from the same SIP using 2 different fetcher objects' do
        expect(fetcher_1.fetch).to eq fetcher_2.fetch
      end
    end

    context 'when :filename options is a regexp' do
      let(:options) { { filename: '/_pod.xml$/', xpath: '/object/details/title' } }
      let(:fetcher) { described_class.new(options) }
      before { fetcher.sip = sip }

      it 'finds the file within the sip' do
        expect(fetcher.fetch).to eq ['"Brain" Cam 1 Tape 1']
      end
    end

    context 'when the fetched value is flagged as required, but is missing' do
      let(:options) { { filename: 'MDPI_40000000542243_pod.xml', xpath: '/does/not/exist', required: true} }
      let(:fetcher) { described_class.new(options) }
      before { fetcher.sip = sip }

      it 'logs the missing value' do
        expect(fetcher).to receive(:report_missing_required_value).exactly(1).times
        fetcher.fetch
      end
    end
  end

  describe '.new' do
    context 'when missing :filename keyword argument' do
      it 'raises an ArgumentError' do
        expect { described_class.new(xpath: 'foo') }.to raise_error ArgumentError
      end
    end

    context 'when missing :xpath keyword argument' do
      it 'raises an ArgumentError' do
        expect { described_class.new(filename: 'boo') }.to raise_error ArgumentError
      end
    end
  end
end