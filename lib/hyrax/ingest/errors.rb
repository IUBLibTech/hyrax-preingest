module Hyrax
  module Ingest
    module Errors
      class InvalidSIPPath < StandardError
        def initialize(invalid_path)
          super("#{invalid_path} is not a valid SIP path")
        end
      end

      class UnknownActiveFedoraModel < StandardError
        def initialize(af_model_class)
          super("Unknown ActiveFedora model type #{af_model_class}")
        end
      end

      class FileNotFoundInSIP < StandardError
        def initialize(string_or_regexp)
          super("No file matching #{string_or_regexp.inspect.to_s} was found in the SIP")
        end
      end

      # TODO: Add helpful messages to any custom errors without them.
      class InvalidFetchOptions < StandardError; end
      class InvalidAssignmentOptions < StandardError; end
    end
  end
end
