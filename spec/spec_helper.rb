lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "faraday/filterable_logger"

RSpec.configure do |config|
  config.order = :random
end
