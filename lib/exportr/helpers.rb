require 'exportr/config'

module Exportr
	
  module Helpers

    extend Exportr::Config

    def log msg=nil
      STDOUT.puts msg ? " | #{msg}" : ""
    end

    def error msg
      STDERR.puts
      STDERR.puts " | ERROR: #{msg}"
      STDERR.puts
      exit 1
    end

    def in_rails_application?
      !!rails_root
    end

    def rails_root
      begin
        return Dir.pwd if File.exists?('script/rails')
        raise
      rescue
        Dir.chdir '..'
        retry unless Dir.pwd == '/'
        return false
      end      
    end

    def config_file
      File.expand_path(CONFIG_FILE, rails_root)
    end

  end

end
