require 'optparse'
require 'exportr/config'

module Exportr

  module Command
    
    extend Exportr::Config

    def self.run *argv
      error "You must run exportr from the root of your application." unless at_root?
      parser.parse! argv
    end

    def self.add val
      vars = load_config
      vars.merge! val
      write_config vars
      hello
    end

    def self.remove val
      vars = load_config
      write_config vars.reject { |k,v| k == val.to_a[0][0] }
    end

    def self.parser
      OptionParser.new do |parser|
        parser.on '-a', '--add VAR', 'Add to ENV' do |val|
          add hashify(val)
        end
        parser.on '-r', '--remove VAR', 'Remove from ENV' do |val|
          remove hashify(val)
        end
      end
    end

    def self.read_config
      error "You must run `rails generate exportr first.`" unless File.exists?("config/exportr.yml")
      File.read("config/exportr.yml")
    end

    def self.write_config vars
      cm = comments
      File.open 'config/exportr.yml', 'w+' do |f|
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

    def self.at_root?
      !!Dir.new(Dir.pwd).collect.detect { |f| f == 'Gemfile' }
    end

    def self.hashify str
      arr = str.split '='
      hash = Hash.new
      hash[arr[0]] = arr[1]
      hash
    end

    def self.error msg
      puts "ERROR: " << msg
      exit 1
    end

  end

end
