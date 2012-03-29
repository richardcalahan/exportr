class ExportGenerator < Rails::Generators::Base

  source_root File.expand_path('../templates', __FILE__)

  def generate_initializer
    copy_file 'export.yml', 'config/export.yml'
    copy_file 'export.rb', 'config/initializers/export.rb'
  end

  def mod_gitignore
    File.open("#{Rails.root}/.gitignore", 'a+') do |f|
      f.puts 
      f.puts '# Ignoring local env export'
      f.puts 'config/export.yml'
    end
  end

end
