module WebammToRails
  module Sources
    module Migrations
      class TableDefinition
        class Presenter
          def initialize(table_definition:)
            @table_definition = table_definition
          end

          def render
            if @table_definition.options&.use_uuid.present?
              "create_table :#{@table_definition.table}, id: :uuid do |t|"
            else
              "create_table :#{@table_definition.table} do |t|"
            end
          end
        end
      end
    end
  end
end
