$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "simplecov"
SimpleCov.start do
  formatter SimpleCov::Formatter::HTMLFormatter
end

require "flimpsy"
require "webmock/rspec"
require "pp"
require "json_expressions/rspec"

Time.zone = "Europe/Berlin"

RSpec.configure do |config|
  config.fail_fast = true
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
