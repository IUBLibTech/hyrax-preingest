require 'hyrax/ingest/assigner/to_active_fedora_model'

module Hyrax
  module Ingest
    module Assigner
      class << self
        def factory(params:)
          if (params[:af_model])
            # TODO: Instead of instantiating the ActiveFedora model here, we
            # need to instantiate it before the class name gets passed to this
            # factory, because it may be the same model instance for the
            # duration of the ingest.
            begin
              klass = params[:af_model].constantize
            rescue NameError => e
              raise Hyrax::Ingest::Errors::UnknownActiveFedoraModel.new(params[:af_model])
            end
            af_model = klass.new

            Hyrax::Ingest::Assigner::ToActiveFedoraModel.new(af_model: af_model, rdf_predicate: params[:rdf_property])
          else
            raise UnrecognizedMappingOptions, "Unrecognized options for mapping to #{params}"
          end
        end
      end
    end
  end
end