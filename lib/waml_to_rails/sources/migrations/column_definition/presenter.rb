module WamlToRails
  module Sources
    module Migrations
      class ColumnDefinition
        class Presenter
          def initialize(column:)
            @column = column
          end

          def render
            if @column.type == 'enum_column'
              base_def = "t.integer :#{@column.name}, null: #{@column.null}"

              if @column.default
                index_of_default = @column.values.index(@column.default)  
                base_def += ", default: #{index_of_default}"
              end

              base_def
            else
              base_def = "t.#{@column.type} :#{@column.name}, null: #{@column.null}"

              if @column.default && @column.type == 'string'
                base_def += ", default: '#{@column.default}'"
              elsif @column.default
                base_def += ", default: #{@column.default}"
              end

              base_def
            end
          end
        end
      end
    end
  end
end
