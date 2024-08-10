require_relative 'definition'

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
          migration_timestamp = Time.now.utc - number_of_migrations
          migration_count = 0

          if enable_uuid?
            migration_content = "class EnableUuid < ActiveRecord::Migration[7.1]\n  def change\n    enable_extension 'pgcrypto'\n  end\nend"
            migrations << {
              path: "db/migrate/#{(migration_timestamp + migration_count).strftime('%Y%m%d%H%M%S')}_enable_uuid.rb",
              content: migration_content
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

        def enable_uuid?
          @database_tables.any? { |table| table.options&.use_uuid.present? }
        end

        def number_of_migrations
          enable_uuid? ? @database_tables.size + 1 : @database_tables.size
        end

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
