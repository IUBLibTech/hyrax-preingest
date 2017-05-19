require 'spec_helper'
require 'hyrax/ingest/mapping'

RSpec.describe Hyrax::Ingest::Mapping do

  let(:mapping) { described_class.new }

  describe '#from' do
    let(:mock_fetcher_factory) { class_double('Hyrax::Ingest::Fetchers::Factory').as_stubbed_const }
    let(:mock_fetch_options) { { foo: :bar } }

    before do
      allow(mock_fetcher_factory).to receive(:create).with(mock_fetch_options).and_return(nil)
    end

    it 'calls Hyrax::Ingest::Fetchers::Factory.create' do
      expect(mock_fetcher_factory).to receive(:create).with(mock_fetch_options)
      mapping.from(mock_fetch_options)
    end

    it 'returns the same instance of Hyrax::Ingest::Mapping' do
      expect(mapping.from(mock_fetch_options)).to eq mapping
    end
  end


  describe '#fetch' do
    context 'when no fetch configuration has been set' do
      it 'raises a InvalidFetchOptions' do
        expect { mapping.fetch }.to raise_error Hyrax::Ingest::Errors::InvalidFetchOptions
      end
    end

    context 'when configured to fetch values from an XML file' do
      it 'fetches values from an XML file' do
        expect(mapping.fetch).to eq 'TODO: PUT IN THE ACTUAL VALUE HERE'
      end
    end
  end

  describe '#assign' do
    context 'when no fetch configuration has been set' do
      it 'raises a InvalidFetchOptions error' do
        expect { mapping.assign }.to raise_error Hyrax::Ingest::Errors::InvalidFetchOptions
      end
    end

    context 'when fetch configuration has been set, but no assignment configuration has been set' do
      before { mapping.from(method: :class)}
      it 'raises an InvalidAssignmentOptions error' do
        expect { mapping.assign }.to raise_error Hyrax::Ingest::Errors::InvalidAssignmentOptions
      end
    end

    context 'when configured to fetch values from an XML file' do
      context 'and when configured to assign to an RDF property' do

        let(:assign_target) { TestModel.new }

        before do
          class TestModel < ActiveFedora::Base
            property test_property, predicate: ::RDF::URI.new('http://example.org#test_property')
          end
        end

        it 'assigns the value to the RDF property from the XML file' do
          expect(assign_target.test_property).to eq 'TODO: PUT IN THE ACTUAL VALUE HERE'
        end
      end
    end
  end
end



# mapping.from(fetch_config).fetch
# => returns a value

# mapping.to(assign_config).assign
# => 