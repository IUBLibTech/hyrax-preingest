require 'hyrax_helper'
require 'hyrax/ingest/runner'

RSpec.describe "Ingesting an ActiveFedora model from XML" do

  before do
    class MyModel < ActiveFedora::Base
      property :title, predicate: 'http://example.org#title' do |index|
        index.as :stored_searchable
      end

      property :description, predicate: 'http://example.org#description'
    end

    @runner = Hyrax::Ingest::Runner.new(
      config_file_path: "#{fixture_path}/ingest_config_examples/ingest_active_fedora_model_from_xml.yml",
      sip_path: "#{fixture_path}/sip_examples/ingest_active_fedora_model_from_xml"
    )

    @runner.run!
  end


  context "with config from ingest_active_fedora_model_from_xml.yml" do
    it "does not have any errors" do
      expect(@runner.errors).to be_empty
    end

    it 'ingests the model with metadata' do
      expect(MyModel.where(title: "Test Title 1").count).to eq 1
    end
  end

  after do
    Object.send(:remove_const, :MyModel)
  end
end
