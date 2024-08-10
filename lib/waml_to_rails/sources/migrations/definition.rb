require_relative 'class_definition/presenter'
require_relative 'table_definition/presenter'

module WamlToRails
  module Sources
    module Migrations
      class Definition
        def initialize(table_definition:)
          @table_definition = table_definition
        end

        def render
          template_path = File.expand_path('template.erb', __dir__)
          template_content = File.read(template_path)
          raw_content = ERB.new(template_content, trim_mode: '-').result(instance_eval { binding })

          ::WamlToRails::Utils::FormatCode.call(raw_content)
        end

        private

        def class_definition
          ::WamlToRails::Sources::Migrations::ClassDefinition::Presenter.new(table_name: table_name).render
        end

        def table_name
          @table_definition.table
        end

        def table_definition
          ::WamlToRails::Sources::Migrations::TableDefinition::Presenter.new(table_definition: @table_definition).render
        end
      end
    end
  end
end
