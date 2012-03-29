module Exportr
  
  module Config

    def global_options
      @global_options ||= []
    end

    def global_option name, *args
      global_options << { :name => name, :args => args }
    end

    def config_file
      "config/exportr.yml"
    end

  end

end
