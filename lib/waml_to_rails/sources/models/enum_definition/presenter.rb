module WamlToRails
  module Sources
    module Models
      class EnumDefinition
        class Presenter
          def initialize(column:)
            @column = column
          end

          def render
            base_def = "enum :#{@column.name}, { #{@column.values.map(&:underscore).map.with_index { |val, i| "#{val}: #{i}" }.join(', ')} }"
            base_def += ", default: :#{@column.default}" if @column.default.present?
            base_def
          end
        end
      end
    end
  end
end
