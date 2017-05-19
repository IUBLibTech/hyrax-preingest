require 'hyrax/ingest/fetcher'
require 'hyrax/ingest/assigner'
require 'hyrax/ingest/map_operation'

module Hyrax
  module Ingest
    class Mapping
      attr_reader :sip, :config

      def initialize(sip:, config:)
        @sip = sip
        @config = config
      end

      def map_operations
        @map_operations ||= config.map do |params|
          fetcher = Hyrax::Ingest::Fetcher.factory(sip: sip, params: params[:from])
          assigner = Hyrax::Ingest::Assigner.factory(params: params[:to])
          Hyrax::Ingest::MapOperation.new(fetcher: fetcher, assigner: assigner)
        end
      end

      def map_all!
        map_operations.each { |map_operation| map_operation.map! }
      end

      # Converts a string to a Regexp if it looks like one.
      # TODO: Handle mode modifiers, like case insensitivity.
      # TODO: This method is used downstream in
      #   Hyrax::Ingest::Fetcher.factory, but it would be nice to recursively
      #   convert all Regexp-like strings to Regexp objects before passing to
      #   the factories.
      # @param [String] The string to convert to a Regexp, if it looks like one.
      # @return [Regexp, String] Returns a Regexp object if the string parameter looks like one,
      #   otherwise returns the string parameter unchanged.
      def self.string_or_regexp(str)
        str = /#{str.sub(/^\//, '').sub(/\/$/, '')}/ if str =~ /^\/.+\/$/
        str
      end
    end
  end
end
