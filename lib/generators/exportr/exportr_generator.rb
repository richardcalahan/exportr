class ExportrGenerator < Rails::Generators::Base

  source_root File.expand_path('../templates', __FILE__)

  def generate_initializer
    copy_file 'exportr.yml', 'config/exportr.yml'
    copy_file 'exportr.rb', 'config/initializers/exportr.rb'
  end

  def mod_gitignore
    File.open("#{Rails.root}/.gitignore", 'a+') do |f|
      f.puts 
      f.puts 
      f.puts '# Ignoring local env export'
      f.puts 'config/exportr.yml'
      f.puts 
    end
  end

end
