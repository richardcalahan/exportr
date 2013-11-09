begin
  require 'exportr.bundle'
rescue LoadError
end

begin
  require 'exportr.so'
rescue LoadError
end

module Exportr; end
