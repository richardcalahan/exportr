module Exportr
	
  module Helpers
    
    def error msg
      puts "ERROR: " << msg
      exit 1
    end

    def at_root?
      !!Dir.new(Dir.pwd).collect.detect { |f| f == 'Gemfile' }
    end

  end

end
