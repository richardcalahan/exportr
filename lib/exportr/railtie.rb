require "exportr/config"

module Exportr
  
  class Railtie < Rails::Railtie

    initializer 'exportr.load_environment_variables' do |app|
      if File.exists? "#{Rails.root}/#{Exportr::Config::CONFIG_FILE}"
        config = YAML.load(File.open("#{Rails.root}/#{Exportr::Config::CONFIG_FILE}"))
        config.each_pair { |key,value| ENV[key] = value } if config
      end
    end

  end

end
