require 'rake'
require 'rake/extensiontask'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new :spec
Rake::ExtensionTask.new 'exportr'

task :default => [ :compile, :spec ]
