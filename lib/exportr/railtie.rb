require 'exportr/helpers'

module Exportr
  
  class Railtie < Rails::Railtie

    extend Exportr::Command::Helpers

    config.before_initialize do
      if File.exists? config_file
        config = YAML.load(File.open(config_file))
        config.each_pair { |key,value| ENV[key] = value } if config
      end
    end

  end

end
