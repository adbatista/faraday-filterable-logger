# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "faraday/filterable_logger/version"

Gem::Specification.new do |spec|
  spec.name = "faraday-filterable_logger"
  spec.version = Faraday::FilterableLogger::VERSION
  spec.authors = ["Westfield Labs"]
  spec.email = [""]

  spec.summary = "A way to filter request params in logger for Faraday."
  spec.description = %(
    A Faraday middleware for params filtering in logs.
  )
  spec.homepage = ""

  spec.files = `git ls-files -z`.split("\x0").reject { |f|
    f.match(%r{^(test|spec|features)/})
  }

  spec.require_paths = ["lib"]
  spec.add_runtime_dependency "faraday", "~> 0.8"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rspec", "~> 3.0"
end
