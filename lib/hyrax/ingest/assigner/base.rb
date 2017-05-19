require 'hyrax/ingest/errors'

module Hyrax
  module Ingest
    module Assigner
      class Base
        def assign(value: nil)
          # no-op; intended to be overwritten
        end
      end
    end
  end
end
