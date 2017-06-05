require 'hyrax/ingest/assigner/base'
require 'active_fedora'

module Hyrax
  module Ingest
    module Assigner
      class ActiveFedoraModel < Base

        def self.valid_options?(options)

          options.key?(:af_model) && options.key?(:property)
        end
      end
    end
  end
end