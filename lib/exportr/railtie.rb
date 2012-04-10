module Exportr
  
  class Railtie < Rails::Railtie
    initializer 'exportr.load_environment_variables' do |app|
      ENV['DUDE'] = 'sweet'
    end
  end

end
