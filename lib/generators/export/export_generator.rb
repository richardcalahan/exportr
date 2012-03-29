class ExportGenerator < Rails::Generators::Base

  source_root File.expand_path('../templates', __FILE__)

  def generate_initializer
    copy_file 'export.yml', 'config/export.yml'
    copy_file 'export.rb', 'config/initializers/export.rb'
  end

end
