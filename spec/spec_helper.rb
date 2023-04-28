# This file is required by all tests
require "linkedin-v2"

# Record and playback LinkedIn API calls
require "vcr"
VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
  config.default_cassette_options = { record: :all } # TODO WHILE WE'RE FIXING THINGS.
end

require "webmock/rspec"

def test_secret(name)
  secrets_path = File.expand_path("../.test_secrets.yml", __dir__)

  @secrets ||=
    begin
      unless File.exists?(secrets_path)
        raise "Missing test secrets file #{secrets_path}}"
      end

      YAML.load(File.open(secrets_path), symbolize_names: true)
    end

  @secrets[name.to_sym]
end
