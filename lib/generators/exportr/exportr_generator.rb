class ExportrGenerator < Rails::Generators::Base

  source_root File.expand_path('../templates', __FILE__)

  def generate_initializer
    copy_file 'exportr.yml', 'config/exportr.yml'
  end

  def mod_gitignore
    return if File.read("#{Rails.root}/.gitignore").match(/config\/exportr.yml/)
    File.open("#{Rails.root}/.gitignore", 'a+') do |f|
      f.puts 
      f.puts '# Ignoring local env export'
      f.puts 'config/exportr.yml'
      f.puts 
    end
  end

end
