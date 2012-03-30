module Exportr
  
  module Config

    # Default config file location. 
    CONFIG_FILE     = 'config/exportr.yml'
    
    # Default error message if CLI is run from anywhere but the root
    NOT_ROOT        = 'You must run exportr from the root of your application.'
    
    # Default error message if there is no config file present.
    NO_CONFIG_FILE  = 'You must run `rails generate exportr` first.'

  end

end
