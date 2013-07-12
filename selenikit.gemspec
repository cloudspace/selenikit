# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'selenikit/version'

Gem::Specification.new do |spec|
  spec.name          = "selenikit"
  spec.version       = Selenikit::VERSION
  spec.authors       = ["Dave Geffken"]
  spec.email         = ["dave@cloudspace.com"]
  spec.description   = %q{Adds rake tasks for selenium-webdriver and capybara-webkit}
  spec.summary       = %q{Adds rake tasks for selenium-webdriver and capybara-webkit}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", "~> 1.3"
  spec.add_dependency "rake"
  spec.add_dependency "rspec-rails"
  spec.add_dependency "capybara"
  spec.add_dependency "capybara-webkit"
  spec.add_dependency "selenium-webdriver"
  
end
