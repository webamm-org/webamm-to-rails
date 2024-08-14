module WamlToRails
  module Sources
    module Migrations
      class ActiveStorageDefinition
        class Presenter
          def initialize(waml_definition:)
            @waml_definition = waml_definition
          end

          def file_name(migration_timestamp)
            "db/migrate/#{migration_timestamp}_create_active_storage_tables.rb"
          end

          def render
            template_path = File.expand_path('template.erb', __dir__)
            template_content = File.read(template_path)
            raw_content = ERB.new(template_content, trim_mode: '-').result(instance_eval { binding })

            ::WamlToRails::Utils::FormatCode.call(raw_content)
          end

          def render?
            @waml_definition.database.schema.any? { |table| table.columns.any? { |column| column.type == 'file' } }
          end
        end
      end
    end
  end
end
