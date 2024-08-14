require_relative 'definition'
require_relative 'uuid_definition/presenter'
require_relative 'active_storage_definition/presenter'

module WamlToRails
  module Sources
    module Migrations
      class FilesList
        def initialize(waml_definition:, database_tables:)
          @waml_definition = waml_definition
          @database_tables = database_tables
        end

        def collection
          migrations = []
          migration_timestamp = Time.now.utc - 1_000
          migration_count = 0

          uuid_presenter = ::WamlToRails::Sources::Migrations::UuidDefinition::Presenter.new(waml_definition: @waml_definition)

          if uuid_presenter.render?
            migrations << {
              path: uuid_presenter.file_name(migration_timestamp + migration_count),
              content: uuid_presenter.render
            }

            migration_count += 1
          end

          active_storage_presenter = ::WamlToRails::Sources::Migrations::ActiveStorageDefinition::Presenter.new(waml_definition: @waml_definition)

          if active_storage_presenter.render?
            migrations << {
              path: active_storage_presenter.file_name(migration_timestamp + migration_count),
              content: active_storage_presenter.render
            }

            migration_count += 1
          end

          models_order = []

          @database_tables.each do |model|
            depending_on = @waml_definition.database.relationships.select { |r| r.source == model.table && r.type == 'belongs_to' }.map(&:destination)
            models_order << { model: model.table, depending_on: depending_on }
          end

          models_hash = models_order.each_with_object({}) do |model, hash|
            hash[model[:model]] = model
          end

          # Topological Sort
          sorted_models = []
          visited = {}
          temp_marks = {}
  
          models_order.each do |model|
            visit(model[:model], models_hash, sorted_models, visited, temp_marks)
          end

          sorted_models.each do |attrs|
            table_name = attrs[:model]
            db_table = @database_tables.find { |t| t.table == table_name }

            migration_code = ::WamlToRails::Sources::Migrations::Definition.new(
              table_definition: db_table, waml_definition: @waml_definition
            ).render
            
            migrations << {
              path: "db/migrate/#{(migration_timestamp + migration_count).strftime('%Y%m%d%H%M%S')}_create_#{db_table.table}.rb",
              content: migration_code
            }

            migration_count += 1
          end

          migrations
        end

        private

        # helper to topologically sort models
        def visit(model, models_hash, sorted_models, visited, temp_marks)
          return if visited[model]
          raise "Circular dependency detected" if temp_marks[model]
          
          temp_marks[model] = true
          models_hash[model][:depending_on].each do |dependency|
            visit(dependency, models_hash, sorted_models, visited, temp_marks)
          end
          temp_marks.delete(model)
          visited[model] = true
          sorted_models << models_hash[model]
        end
      end
    end
  end
end
