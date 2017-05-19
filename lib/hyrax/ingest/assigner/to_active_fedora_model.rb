require 'hyrax/ingest/assigner/base'
require 'active_fedora'

module Hyrax
  module Ingest
    module Assigner
      class ToActiveFedoraModel < Base
        attr_reader :af_model, :rdf_predicate

        def initialize(af_model:, rdf_predicate: nil)
          raise ArgumentError, "Argument af_model must be an instance of ActiveRecord::Base (or subclass), but #{af_model.class} was given" unless af_model.is_a? ActiveFedora::Base
          @af_model = af_model
          @rdf_predicate = rdf_predicate
        end

        def assign(value:)
          binding.pry
        end
      end
    end
  end
end