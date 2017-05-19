require 'hyrax/ingest/mapping'
require 'hyrax/ingest/fetcher/from_xml'

module Hyrax
  module Ingest
    module Fetcher
      class << self
        def factory(sip:, params:)
          if params[:xml_file]
            # TODO: Move this String-to-Regexp logic to a better location?
            xml_file = sip.files.find do |file|
              filename = File.basename(file.path)
              # If params[:xml_file] is a string that looks like a Regex, then
              # treat it like a Regexp
              if params[:xml_file] =~ /^\/.+\/$/
                filename =~ /#{params[:xml_file].sub(/^\//, '').sub(/\/$/, '')}/
              else
                # Compare SIP file as regular string
                filename == params[:xml_file]
              end
            end
            raise Hyrax::Ingest::Errors::FileNotFoundInSIP.new(params[:xml_file]) if xml_file.nil?
            Hyrax::Ingest::Fetcher::FromXML.new(xml_file: xml_file, xpath: params[:xpath])
          else
            raise UnrecognizedMappingOptions, "Unrecognized options for mapping from #{params}"
          end
        end
      end
    end
  end
end