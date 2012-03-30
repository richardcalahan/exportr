module Exportr
	
  module Helpers
    
    def log msg
      STDOUT.puts "\n | #{msg}\n\n"
    end

    def error msg
      STDERR.puts "\n | ERROR: #{msg}\n\n"
      exit 1
    end

    def at_root?
      !!Dir.new(Dir.pwd).collect.detect { |f| f == 'Gemfile' }
    end

  end

end
