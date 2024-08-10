module WamlToRails
  module Sources
    module Models
      class AssociationDefinition
        class Presenter
          UnknownAssociationType = Class.new(StandardError)

          def initialize(association:)
            @association = association
          end

          def render
            case @association['type']
            when 'belongs_to'
              assoc_def = "belongs_to :#{@association['destination'].underscore.singularize}"
              assoc_def << ", optional: true" unless @association['required']
              assoc_def
            else
              raise UnknownAssociationType, @association['type']
            end
          end
        end
      end
    end
  end
end
