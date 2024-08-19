module WebammToRails
  module Sources
    module Models
      class AttachmentDefinition
        class Presenter
          def initialize(column:)
            @column = column
          end

          def render
            if @column.name == @column.name.pluralize
              "has_many_attached :#{@column.name}"
            else
              "has_one_attached :#{@column.name}"
            end
          end
        end
      end
    end
  end
end
