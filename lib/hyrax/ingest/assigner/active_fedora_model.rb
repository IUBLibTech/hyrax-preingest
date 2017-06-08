require 'hyrax/ingest/assigner/base'
require 'active_fedora'

module Hyrax
  module Ingest
    module Assigner
      class ActiveFedoraModel < Base
        attr_reader :af_model, :rdf_predicate

        def initialize(af_model:, rdf_predicate:)
          @af_model = af_model
          @rdf_predicate = rdf_predicate
        end

        def assign(value)
          # TODO: Account for multi-value vs. single value
          af_model.send(af_model_property_from_rdf_predicates).set(value)
        end

        private

          def af_model_property_from_rdf_predicates
            property = af_model.send(:properties).select do |_att, config|
              # TODO: Allow rdf_predicate to be a regex
              config.predicate == rdf_predicate
            end

            # TODO: Handle edge cases where:
            #  1) The rdf_predicate given matches ZERO properties
            #  2) The rdf_predicate given matches MULTIPLE properties.
            property.keys.first.to_sym
          end
      end
    end
  end
end