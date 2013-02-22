module Exportr

  module Base

    # Default config file location. 
    CONFIG_FILE       = 'config/exportr.yml'

    SYSTEM_FILE_PATH = '/etc'
    
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

    def system_config_file
      prefix = ENV['EXPORTR_PREFIX'] || SYSTEM_FILE_PATH
      "#{prefix}/#{Rails.application.class.to_s.split('::')[0].downcase}_#{ENV['RAILS_ENV'] || 'development'}.yml"
    end

  end

end
