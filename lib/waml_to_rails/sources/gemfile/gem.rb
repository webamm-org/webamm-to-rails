module WamlToRails
  module Sources
    module Gemfile
      class Gem < Data.define(:name, :version, :required, :group, :platforms)
      end
    end
  end
end
