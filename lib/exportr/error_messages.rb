module Exportr

  module ErrorMessages
    
    def not_root
      "You must run exportr from the root of your application."
    end

    def no_config_file
      "You must run `rails generate exportr` first."
    end

  end

end
