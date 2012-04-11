module Exportr

  module Command

    module Core

      def add val
        log
        log "Adding #{val.to_a[0][0]}=#{val.to_a[0][1]} to your environment..."
        write_config load_config.merge(val)
      end

      def remove val
        log
        log "Removing #{val.to_a[0][0]} from your environment..."
        write_config load_config.reject { |k,v| k == val.to_a[0][0] }
      end

      def clear
        log
        log "Clearing environment variables..."
        write_config Hash.new
      end

      def list
        log
        log "Exportr Environment Variables"
        log "--------------------------------------------------"
        vars = load_config.to_a
        vars.each { |var| log "#{var[0]}=#{var[1]}" }
        log("none.") unless vars.any?
        log
      end

      def version
        log
        log "Version #{Exportr::VERSION}"
        log
      end

      def help
        STDOUT.puts
        STDOUT.puts parser.help
        STDOUT.puts
      end

    end

  end

end

