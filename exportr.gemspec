$:.push File.expand_path("../lib", __FILE__)

require 'exportr/version'

Gem::Specification.new do |gem|
  gem.name          = 'exportr'
  gem.version       = Exportr::VERSION
  gem.authors       = ['Richard Calahan']
  gem.email         = ['richard@calahan.me']
  gem.description   = 'Helps manage ruby application specific environment variables for multiple apps in development.'
  gem.summary       = 'Ruby environment variable manager'
  gem.homepage      = 'https://github.com/richardcalahan/exportr'
  gem.files         = `git ls-files`.split($/)
  gem.extensions    = Dir.glob 'ext/**/extconf.rb'
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rake-compiler'
  gem.add_development_dependency 'rspec'
end
