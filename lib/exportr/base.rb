module Exportr

  module Base

    # Default config file location. 
    CONFIG_FILE = 'config/exportr.yml'
    
    def self.extended base
      constants.each do |const| 
        base.const_set const, const_get(const)
      end
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
