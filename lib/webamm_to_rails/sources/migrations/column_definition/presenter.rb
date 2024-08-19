module WebammToRails
  module Sources
    module Migrations
      class ColumnDefinition
        class Presenter
          def initialize(column:)
            @column = column
          end

          def render
            return if @column.type == 'file'

            if @column.type == 'enum_column'
              base_def = "t.integer :#{@column.name}, null: #{@column.null}"

              if @column.default.present?
                index_of_default = @column.values.index(@column.default)  
                base_def += ", default: #{index_of_default}"
              end

              base_def
            else
              base_def = "t.#{@column.type} :#{@column.name}, null: #{@column.null}"

              if @column.default.present? && @column.type == 'string'
                base_def += ", default: '#{@column.default}'"
              elsif @column.default.present?
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
