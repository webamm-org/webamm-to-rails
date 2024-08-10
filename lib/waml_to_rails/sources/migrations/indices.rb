require_relative 'index_definition/presenter'

module WamlToRails
  module Sources
    module Migrations
      class Indices
        def initialize(table_definition:)
          @table_definition = table_definition
        end

        def collection
          @table_definition.indices.map do |index|
            ::WamlToRails::Sources::Migrations::IndexDefinition::Presenter.new(table_name: @table_definition.table, index: index).render
          end
        end
      end
    end
  end
end
