require 'hyrax/ingest/fetcher/base'
require 'nokogiri'

module Hyrax
  module Ingest
    module Fetcher
      class FromXML < Base
        attr_accessor :xml, :xpath

        # option opts [String] :xml The xpath used to fetch the value from XML.
        # option opts [String] :xpath The xpath used to fetch the value from XML.
        def initialize(xml_file:, xpath:)
          raise ArgumentError, "Argument xml_file must respond to #read, but #{xml_file.class} was given" unless xml_file.respond_to?(:read)
          @xml_file = xml_file
          @xpath = xpath
        end

        def fetch
          noko.xpath(xpath).text
        end

        private

          def noko
            @noko ||= begin
              n = Nokogiri::XML(xml)
              n.remove_namespaces!
            end
          end
      end
    end
  end
end