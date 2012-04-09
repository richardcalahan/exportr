class ExportrGenerator < Rails::Generators::Base

  source_root File.expand_path('../templates', __FILE__)

  def generate_initializer
    copy_file 'exportr.yml', 'config/exportr.yml'
    #    copy_file 'exportr.rb', 'config/initializers/exportr.rb'
    application '
    # Loads export.yml and sets key=value to the local environment
    config.before_initialize do
      require "exportr/config"
      if File.exists? "#{Rails.root}/#{Exportr::Config::CONFIG_FILE}"
        config = YAML.load(File.open("#{Rails.root}/#{Exportr::Config::CONFIG_FILE}"))
        config.each_pair { |key,value| ENV[key] = value } if config
      end
    end'
  end

  def mod_gitignore
    return if File.read("#{Rails.root}/.gitignore").match(/config\/exportr.yml/)
    File.open("#{Rails.root}/.gitignore", 'a+') do |f|
      f.puts 
      f.puts 
      f.puts '# Ignoring local env export'
      f.puts 'config/exportr.yml'
      f.puts 
    end
  end

end
