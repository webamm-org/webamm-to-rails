require_relative 'attachment_definition/presenter'

module WebammToRails
  module Sources
    module Models
      class Attachments
        def initialize(table_definition:)
          @table_definition = table_definition
        end

        def collection
          attachment_columns.map do |column|
            ::WebammToRails::Sources::Models::AttachmentDefinition::Presenter.new(column: column).render
          end
        end

        private

        def attachment_columns
          @table_definition.columns.select { |col| col.type == 'file' }
        end
      end
    end
  end
end
