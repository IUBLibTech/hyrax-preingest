require 'hyrax/ingest/errors'

module Hyrax
  module Ingest
    module Fetcher
      class Base
        def fetch
          # no-op; intended to be overwritten
        end

        def self.validate_options
          # no-op; intended to be overwritten
        end
      end
    end
  end
end