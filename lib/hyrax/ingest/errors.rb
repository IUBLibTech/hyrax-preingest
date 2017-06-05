module Hyrax
  module Ingest
    # Base class that allows for rescuing from all Hyrax::Ingest errors.
    # Intentionally no-op.
    class Error < StandardError; end

    module Errors
      class InvalidSIPPath < Hyrax::Ingest::Error
        def initialize(invalid_path)
          super("#{invalid_path} is not a valid SIP path")
        end
      end

      class UnknownActiveFedoraModel < Hyrax::Ingest::Error
        def initialize(af_model_class)
          super("Unknown ActiveFedora model type #{af_model_class}")
        end
      end

      class FileNotFoundInSIP < Hyrax::Ingest::Error
        def initialize(string_or_regexp)
          super("No file matching #{string_or_regexp.inspect.to_s} was found in the SIP")
        end
      end

      class UnknownAssignerClass < Hyrax::Ingest::Error
        def initialize(class_name, available_classes)
          super("Assigner class '#{class_name}' not found. Available assigner classes are: #{available_classes.to_a.join(', ')}")
        end
      end

      class AmbiguousAssignerClass < Hyrax::Ingest::Error
        def initialize(class_name, matching_classes)
          super("Assigner class name '#{class_name}' is ambiguous; could mean any one of the following classes: #{matching_classes.to_a.join(',')}. Please use namespaces in the class name to be more specific.")
        end
      end

      class UnknownFetcherClass < Hyrax::Ingest::Error
        def initialize(class_name, available_classes)
          super("Fetcher class '#{class_name}' not found. Available fetcher classes are: #{available_classes.to_a.join(', ')}")
        end
      end

      class AmbiguousFetcherClass < Hyrax::Ingest::Error
        def initialize(class_name, matching_classes)
          super("Fetcher class name '#{class_name}' is ambiguous; could mean any one of the following classes: #{matching_classes.to_a.join(',')}. Please use namespaces in the class name to be more specific.")
        end
      end

      class AmbiguousFetchOptions < Hyrax::Ingest::Error
        def initialize(ambiguous_options)
          super("Could not determine which fetcher class to use given the following options: #{ambiguous_options}")
        end
      end

      class MissingRequiredFetchOptions < Hyrax::Ingest::Error
        def initialize(missing_options)
          super("Missing required assignment options: #{missing_options}")
        end
      end

      class InvalidFetchOptions < Hyrax::Ingest::Error
        def initialize(invalid_options)
          super("Invalid fetch options: #{invalid_options}")
        end
      end

      class AmbiguousAssignmentOptions < Hyrax::Ingest::Error
        def initialize(ambiguous_options)
          super("Could not determine which assigner class to use given the following options: #{ambiguous_options}")
        end
      end

      class MissingRequiredAssignmentOptions < Hyrax::Ingest::Error
        def initialize(missing_options)
          super("Missing required assignment options: #{missing_options}")
        end
      end

      class InvalidAssignmentOptions < Hyrax::Ingest::Error
        def initialize(invalid_options)
          super("Invalid assignment options: #{invalid_options}")
        end
      end
    end
  end
end
