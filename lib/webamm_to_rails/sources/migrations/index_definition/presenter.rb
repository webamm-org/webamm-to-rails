module WebammToRails
  module Sources
    module Migrations
      class IndexDefinition
        class Presenter
          def initialize(table_name:, index:)
            @table_name = table_name
            @index = index
          end

          def render
            base_def = if @index.columns.size == 1
              "add_index :#{@table_name}, :#{@index.columns.first}"
            else
              "add_index :#{@table_name}, %i[#{@index.columns.join(' ')}]"
            end

            base_def += ", unique: true" if @index.unique

            base_def
          end

          private

          def index_name
            base_name = @index.columns.join('_')

            "#{base_name[0..19]}_idx"
          end
        end
      end
    end
  end
end
