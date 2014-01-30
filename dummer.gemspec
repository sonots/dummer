# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dummer/version'

Gem::Specification.new do |spec|
  spec.name          = "dummer"
  spec.version       = Dummer::VERSION
  spec.authors       = ["sonots"]
  spec.email         = ["sonots@gmail.com"]
  spec.description   = %q{Generates dummy log data for Fluentd benchmark}
  spec.summary       = %q{Generates dummy log data for Fluentd benchmark}
  spec.homepage      = "https://github.com/sonots/dummer"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "serverengine"
  spec.add_dependency "fluent-logger"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-nav"
end
