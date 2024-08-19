module WebammToRails
  module Sources
    module Migrations
      class ClassDefinition
        class Presenter
          def initialize(table_name:)
            @table_name = table_name
          end

          def render(rails_version: '7.1')
            "class Create#{@table_name.classify.pluralize} < ActiveRecord::Migration[#{rails_version}]"
          end
        end
      end
    end
  end
end
