require 'rufo'

module WamlToRails
  module Utils
    class FormatCode
      def self.call(code)
        Rufo.format(code)
      end
    end
  end
end
