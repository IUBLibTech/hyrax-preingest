# Set of helper methods related to test fixtures.
module FixtureHelpers
  # @param [String] relative_path The path to a file, relative to the fixtures directory.
  # @return [File]
  def fixture(relative_path)
    File.new(File.expand_path("../../fixtures/#{relative_path}", __FILE__))
  end
end
