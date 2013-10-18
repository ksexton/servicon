# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'servicon/version'

Gem::Specification.new do |spec|
  spec.name          = "servicon"
  spec.version       = Servicon::VERSION
  spec.authors       = ["Kyle Sexton"]
  spec.email         = ["ks@mocker.org"]
  spec.description   = %q{Generate ANSI or ASCII identicons}
  spec.summary       = %q{Generate ANSI or ASCII identicons}
  spec.homepage      = "http://www.github.com/~ksexton/servicon"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "paint"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
