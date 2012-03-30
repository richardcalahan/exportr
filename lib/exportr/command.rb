require 'optparse'
require 'exportr/config'
require 'exportr/error_messages'
require 'exportr/helpers'
require 'yaml'

module Exportr

  module Command
    
    extend  Exportr::Config
    include Exportr::ErrorMessages
    extend  Exportr::Helpers

    global_option :add, '-a', '--add VAR', 'Add environment variable'
    global_option :remove, '-r', '--remove VAR', 'Remove environment variable'

    def self.run *argv
      error NOT_ROOT unless at_root?
      parser.parse! argv
    end

    def self.add val
      vars = load_config
      vars.merge! val
      write_config vars
    end

    def self.remove val
      vars = load_config
      write_config vars.reject { |k,v| k == val.to_a[0][0] }
    end

    def self.parser
      OptionParser.new do |parser|
        global_options.each do |opt|
          parser.on *opt[:args] do |val|
            send opt[:name], hashify(val)
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
      arr = str.split '='
      hash = Hash.new
      hash[arr[0]] = arr[1]
      hash
    end

  end

end
