class ExportrGenerator < Rails::Generators::Base

  source_root File.expand_path('../templates', __FILE__)

  def generate_initializer
    copy_file 'exportr.yml', 'config/exportr.yml'

    # Decrecation warning
    if File.exists?("#{Rails.root}/config/initializers/exportr.rb")
      puts
      puts 'Deprecation Warning: Exportr no longer uses config/initialzers/exportr.rb to load environment variables.'
      puts 'Please remove before restarting your server.'
      puts
    end

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
