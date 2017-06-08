require 'spec_helper'
require 'hyrax/ingest/assigner/active_fedora_model'

RSpec.describe Hyrax::Ingest::Assigner::ActiveFedoraModel do

  before do
    class TestActiveFedoraModel < ActiveFedora::Base
      property :foo, predicate: ::RDF::URI.new('http://example.org#foo')
    end
  end

  describe '#assign' do

    let(:options) { { af_model: af_model, rdf_predicate: 'http://example.org#foo'} }
    let(:af_model) { TestActiveFedoraModel.new }
    subject { described_class.new(options) }

    before do
      subject.assign("some value")
    end

    it 'assigns a value to the property of an ActiveFedora model based on the assign options' do
      expect(af_model.foo).to eq ["some value"]
    end
  end
end
