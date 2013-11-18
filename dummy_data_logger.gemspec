# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dummy_data_logger/version'

Gem::Specification.new do |spec|
  spec.name          = "dummy_data_logger"
  spec.version       = DummyDataLogger::VERSION
  spec.authors       = ["sonots"]
  spec.email         = ["sonots@gmail.com"]
  spec.description   = %q{Generates dummy data and writes into a log file}
  spec.summary       = %q{Generates dummy data and writes into a log file}
  spec.homepage      = "https://github.com/sonots/dummy_data_logger"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "serverengine"
  spec.add_dependency "active_support"
  spec.add_dependency "i18n"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-nav"
end
