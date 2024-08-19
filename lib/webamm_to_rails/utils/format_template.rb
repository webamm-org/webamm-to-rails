require 'htmlbeautifier'

module WebammToRails
  module Utils
    class FormatTemplate
      def self.call(raw_content)
        HtmlBeautifier.beautify(raw_content)
      end
    end
  end
end
