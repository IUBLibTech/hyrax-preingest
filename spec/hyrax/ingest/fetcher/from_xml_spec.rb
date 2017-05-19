require 'spec_helper'
require 'hyrax/ingest/fetcher/from_xml'


RSpec.describe Hyrax::Ingest::Fetcher::FromXML do
  describe '#fetch' do
    context 'when #xml contains valid XML and #xpath contains valid xpath' do
      subject { described_class.new }

      before do
        subject.xml = fixture('sip_examples/40000000054496_20160213-082528/MDPI_40000000542243_pod.xml')
        subject.xpath = '/object/details/title'
      end

      it 'returns the value from the XML pointed to by the xpath' do
        expect(subject.fetch).to eq '"Brain" Cam 1 Tape 1'
      end
    end
  end
end