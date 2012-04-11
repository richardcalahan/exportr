require 'exportr/base'
require 'exportr/command/core'
require 'exportr/command/helpers'
require 'exportr/command/messages'
require 'exportr/version'
require 'optparse'
require 'yaml'

module Exportr

  module Command

    extend Exportr::Base
    extend Exportr::Command::Core
    extend Exportr::Command::Helpers
    extend Exportr::Command::Messages

    def self.core_options
      @global_options ||= []
    end

    def self.core_option name, *args
      core_options << { :name => name, :args => args }
    end

    core_option :add, '-a', '--add KEY=VALUE', 'Add environment variable'
    core_option :remove, '-r', '--remove KEY', 'Remove environment variable'
    core_option :clear, '-c', '--clear', 'Clear out all environment variables'
    core_option :list, '-l', '--list', 'List all environment variables'
    core_option :version, '-v', '--version', 'Get exportr version number'
    core_option :help, '-h', '--help', 'Print this message'

    def self.run *argv
      error NOT_RAILS unless in_rails_application?
      argv.any? ? parser.parse!(argv) : help
    end

    def self.parser
      OptionParser.new do |parser|
        parser.banner = "Usage:\n    exportr [options]"
        parser.separator "\nOptions: "
        core_options.each do |opt|
          parser.on *opt[:args] do |val| 
            send(opt[:name], hashify(val)) rescue send opt[:name]
          end
        end
      end
    end

    def self.read_config
      error NO_CONFIG_FILE unless File.exists?(config_file)
      File.read config_file
    end

    def self.write_config vars
      cm = comments
      File.open config_file, 'w+' do |f|
        f.write cm << "\n" << dump_config(vars)
      end
      log "Done."
      log
    end

    def self.load_config
      YAML.load(read_config) || Hash.new
    end

    def self.dump_config vars
      YAML.dump(vars)
    end

    def self.comments
      read_config.match(/(^\#.*\n)+/).to_s
    end

    def self.hashify str
      arr = str.split('=') rescue []
      hash = Hash.new
      hash[arr[0]] = arr[1]
      hash
    end

  end

end
