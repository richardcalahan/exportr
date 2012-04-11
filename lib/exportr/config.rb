module Exportr
  
  module Config

    # Default config file location. 
    CONFIG_FILE     = 'config/exportr.yml'
    
    def self.extended base
      constants.each do |const| 
        base.const_set const, const_get(const)
      end
    end

  end

end
