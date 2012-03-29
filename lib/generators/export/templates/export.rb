# Loads export.yml and sets key=value to the local environment

config = YAML.load(File.open("#{Rails.root}/config/export.yml"))
unless Rails.env == 'production'
  config.each_pair { |key,value| ENV[key] = value }
end
