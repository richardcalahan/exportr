require 'exportr/config'
require 'exportr/helpers'
require 'exportr/version'
require 'optparse'
require 'yaml'

module Exportr

  module Command
    
    extend Exportr::Helpers
    extend Exportr::Config

    def self.global_options
      @global_options ||= []
    end

    def self.global_option name, *args
      global_options << { :name => name, :args => args }
    end

    global_option :add, '-a', '--add KEY=VALUE', 'Add environment variable'
    global_option :remove, '-r', '--remove KEY', 'Remove environment variable'
    global_option :clear, '-c', '--clear', 'Clear out all environment variables'
    global_option :list, '-l', '--list', 'List all environment variables'
    global_option :version, '-v', '--version', 'Get exportr version number'
    global_option :help, '-h', '--help', 'Print this message'

    def self.run *argv
      error NOT_RAILS unless in_rails_application?
      argv.any? ? parser.parse!(argv) : help
    end

    def self.add val
      log
      log "Adding #{val.to_a[0][0]}=#{val.to_a[0][1]} to your environment..."
      write_config load_config.merge(val)
    end

    def self.remove val
      log
      log "Removing #{val.to_a[0][0]} from your environment..."
      write_config load_config.reject { |k,v| k == val.to_a[0][0] }
    end

    def self.clear
      log
      log "Clearing environment variables..."
      write_config Hash.new
    end

    def self.list
      log
      log "Exportr Environment Variables"
      log "--------------------------------------------------"
      vars = load_config.to_a
      vars.each { |var| log "#{var[0]}=#{var[1]}" }
      log("none.") unless vars.any?
      log
    end

    def self.version
      log
      log "Version #{Exportr::VERSION}"
      log
    end

    def self.help
      STDOUT.puts
      STDOUT.puts parser.help
      STDOUT.puts
    end

    def self.parser
      OptionParser.new do |parser|
        parser.banner = "Usage:\n    exportr [options]"
        parser.separator "\nOptions: "
        global_options.each do |opt|
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
