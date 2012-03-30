require 'exportr/config'

# Loads export.yml and sets key=value to the local environment
if File.exists? "#{Rails.root}/#{Exportr::Config::CONFIG_FILE}"
  config = YAML.load(File.open("#{Rails.root}/#{Exportr::Config::CONFIG_FILE}"))
  config.each_pair { |key,value| ENV[key] = value } if config
end
