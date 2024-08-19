require_relative 'sets/authentication'
require_relative 'default_set'

module WebammToRails
  module Sources
    module Gemfile
      class ProjectSet
        def initialize(waml_definition:)
          @waml_definition = waml_definition
        end

        def collection
          gems = ::WebammToRails::Sources::Gemfile::DefaultSet::GEMS
          gems |= ::WebammToRails::Sources::Gemfile::Sets::Authentication.new(waml_definition: @waml_definition).collection

          gems
        end
      end
    end
  end
end
