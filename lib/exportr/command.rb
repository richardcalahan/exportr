require 'exportr/config'
require 'exportr/helpers'
require 'optparse'
require 'yaml'

module Exportr

  module Command
    
    extend Exportr::Config
    extend Exportr::Helpers

    def self.global_options
      @global_options ||= []
    end

    def self.global_option name, *args
      global_options << { :name => name, :args => args }
    end

    global_option :add, '-a', '--add VAR', 'Add environment variable'
    global_option :remove, '-r', '--remove VAR', 'Remove environment variable'
    global_option :clear, '-c', '--clear', 'Clear out all environment variables'
    global_option :list, '-l', '--list', 'List all environment variables'

    def self.run *argv
      error NOT_ROOT unless at_root?
      parser.parse! argv
    end

    def self.add val
      log "Adding #{val.to_a[0][0]}=#{val.to_a[0][1]} to your environment..."
      write_config load_config.merge(val)
    end

    def self.remove val
      log "Removing #{val.to_a[0][0]} from your environment..."
      write_config load_config.reject { |k,v| k == val.to_a[0][0] }
    end

    def self.clear val=nil
      log "Clearing environment variables..."
      write_config Hash.new
    end

    def self.list val=nil
      log "Exportr Environment Variables"
      log "--------------------------------------------------"
      vars = load_config.to_a
      vars.each do |var|
        log "#{var[0]}=#{var[1]}"
      end
      log("none.") unless vars.any?
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
      log "Done."
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
