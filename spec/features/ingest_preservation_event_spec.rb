require 'hyrax_helper'
require 'hyrax/ingest/runner'
# require 'hyrax/preservation/event'

RSpec.describe "Ingesting a Hyrax::Preservation::Event" do

  let(:config_file_path) { "#{fixture_path}/ingest_config_examples/ingest_preservation_event.yml" }

  before do
    @runner = Hyrax::Ingest::Runner.new(config_file_path: config_file_path)
    @runner.run!
  end

  context "with config from ingest_preservation_event.yml" do

    let(:all_preservation_events) { Hyrax::Preservation::Event.all }
    let(:preservation_event) { all_preservation_events.first }

    it 'ingests the correct number of Hyrax::Preservation::Event models' do
      expect(all_preservation_events.count).to eq 1
    end

    it 'ingests the PREMIS Event Type' do
      expect(preservation_event.premis_event_type.first.to_uri.to_s).to eq 'http://id.loc.gov/vocabulary/preservation/eventType/ing'
    end

    it 'ingests the PREMIS agent' do
      expect(preservation_event.premis_agent.first.to_uri.to_s).to eq 'mailto:admin@example.org'
    end
  end
end
