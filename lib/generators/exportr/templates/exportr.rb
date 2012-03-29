# Loads export.yml and sets key=value to the local environment

if File.exists? "#{Rails.root}/config/exportr.yml"
  config = YAML.load(File.open("#{Rails.root}/config/exportr.yml"))
  config.each_pair { |key,value| ENV[key] = value } if config
end
