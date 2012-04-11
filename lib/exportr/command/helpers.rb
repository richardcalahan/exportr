require 'exportr/base'

module Exportr

  module Command
    
    module Helpers

      extend Exportr::Base

      def log msg=nil
        STDOUT.puts msg ? " | #{msg}" : ""
      end

      def error msg
        STDERR.puts
        STDERR.puts " | ERROR: #{msg}"
        STDERR.puts
        exit 1
      end

      def in_rails_application?
        !!rails_root
      end

    end

  end

end
