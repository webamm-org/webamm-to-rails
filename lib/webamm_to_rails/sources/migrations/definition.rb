require_relative 'class_definition/presenter'
require_relative 'table_definition/presenter'
require_relative 'columns'
require_relative 'indices'
require_relative 'associations'

module WebammToRails
  module Sources
    module Migrations
      class Definition
        def initialize(table_definition:, waml_definition:)
          @table_definition = table_definition
          @waml_definition = waml_definition
        end

        def render
          template_path = File.expand_path('template.erb', __dir__)
          template_content = File.read(template_path)
          raw_content = ERB.new(template_content, trim_mode: '-').result(instance_eval { binding })

          ::WebammToRails::Utils::FormatCode.call(raw_content)
        end

        private

        def class_definition
          ::WebammToRails::Sources::Migrations::ClassDefinition::Presenter.new(table_name: table_name).render
        end

        def table_name
          @table_definition.table
        end

        def table_definition
          ::WebammToRails::Sources::Migrations::TableDefinition::Presenter.new(table_definition: @table_definition).render
        end

        def columns
          ::WebammToRails::Sources::Migrations::Columns.new(waml_definition: @waml_definition, table_definition: @table_definition).collection
        end

        def indices
          ::WebammToRails::Sources::Migrations::Indices.new(waml_definition: @waml_definition, table_definition: @table_definition).collection
        end

        def associations
          ::WebammToRails::Sources::Migrations::Associations.new(table_definition: @table_definition, waml_definition: @waml_definition).collection
        end
      end
    end
  end
end
