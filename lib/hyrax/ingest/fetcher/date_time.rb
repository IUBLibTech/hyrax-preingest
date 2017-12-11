require 'hyrax/ingest/errors'
require 'hyrax/ingest/sip'
require 'date'

module Hyrax
  module Ingest
    module Fetcher
      class DateTime < Base
        attr_reader :date_time_method

        def initialize(date_time_method='')
          @date_time_method = date_time_method.to_sym
        end

        def fetch
          ::DateTime.send(date_time_method)
        rescue NoMethodError => e
          raise Hyrax::Ingest::Errors::InvalidFetchOption.new(date_time_method)
        end
      end
    end
  end
end
