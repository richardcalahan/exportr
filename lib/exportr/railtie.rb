require 'exportr/base'

module Exportr
  
  class Railtie < Rails::Railtie

    extend Exportr::Base

    config.before_configuration do

      if File.exists? config_file
        config = YAML.load(File.open(config_file))
        config.each_pair { |key,value| ENV[key] = value } if config
      end

      if File.exists? system_config_file
        config = YAML.load(File.open(system_env_file))
        config.each_pair { |key,value| ENV[key] = value } if config
      end

    end

  end

end
