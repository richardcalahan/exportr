require 'exportr/config'
require 'exportr/helpers'
require 'optparse'
require 'yaml'

module Exportr

  module Command
    
    extend   Exportr::Config
    include  Exportr::Config
    extend   Exportr::Helpers

    def self.global_options
      @global_options ||= []
    end

    def self.global_option name, *args
      global_options << { :name => name, :args => args }
    end

    global_option :add, '-a', '--add VAR', 'Add environment variable'
    global_option :remove, '-r', '--remove VAR', 'Remove environment variable'

    def self.run *argv
      error NOT_ROOT unless at_root?
      parser.parse! argv
    end

    def self.add val
      write_config load_config.merge(val)
    end

    def self.remove val
      write_config load_config.reject { |k,v| k == val.to_a[0][0] }
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
      error NO_CONFIG_FILE unless File.exists?(CONFIG_FILE)
      File.read CONFIG_FILE
    end

    def self.write_config vars
      cm = comments
      File.open CONFIG_FILE, 'w+' do |f|
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
