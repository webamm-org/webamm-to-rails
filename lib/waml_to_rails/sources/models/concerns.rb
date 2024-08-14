module WamlToRails
  module Sources
    module Models
      class Concerns
        def initialize(table_definition:, waml_definition:)
          @table_definition = table_definition
          @waml_definition = waml_definition
        end

        def collection
          return [] if table_authentication.blank?
          return [] if table_authentication.features.blank? || !table_authentication.features.include?('online_indication')

          ['include DeviseOnlineable']
        end

        private

        def table_authentication
          return if @waml_definition.authentication.blank?

          @waml_definition.authentication.find { |auth| auth.table == @table_definition.table }
        end
      end
    end
  end
end
