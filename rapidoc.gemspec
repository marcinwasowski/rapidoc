# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rapidoc/version'

Gem::Specification.new do |gem|
  gem.name          = "rapidoc"
  gem.version       = Rapidoc::VERSION
  gem.authors       = ["Rafael Jurado"]
  gem.email         = ["rjurado@nosolosoftware.biz"]
  gem.description   = %q{Generates REST API documentation.}
  gem.summary       = %q{Generates REST API documentation.}
  gem.homepage      = "https://github.com/marcinwasowski/rapidoc.git"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency  "rails", ">= 3.2.0"
  gem.add_dependency  "handlebars", "~> 0.4.0"
  gem.add_development_dependency  "rspec-rails"
  gem.add_development_dependency  "sqlite3", "~> 1.3.7"
  gem.add_development_dependency  "capybara"
  gem.add_development_dependency  "rack"
end
