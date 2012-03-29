# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "exportr/version"

Gem::Specification.new do |s|
  s.name        = "exportr"
  s.version     = Exportr::VERSION
  s.authors     = ["Richard Calahan"]
  s.email       = ["richard@alldayeveryday.com"]
  s.homepage    = ""
  s.summary     = 'Rails environment variable manager'
  s.description = 'Helps manage rails application specific environment variables for multiple apps in development.'

  s.rubyforge_project = "exportr"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  #s.add_development_dependency "optparse"
  # s.add_runtime_dependency "optparse"

end
