module Exportr
  
  module Command

    module Messages

      # Default error message if CLI is run outside rails
      NOT_RAILS       = 'Could not detect rails application.'
      
      # Default error message if there is no config file present.
      NO_CONFIG_FILE  = 'You must run `rails generate exportr` first.'

      def self.extended base
        constants.each do |const| 
          base.const_set const, const_get(const)
        end
      end

    end

  end

end
