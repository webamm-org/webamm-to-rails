require 'dry-struct'

module Types
  include Dry.Types()
end

module WamlToRails
  class Definition < Dry::Struct
    attribute :database do
      attribute :engine, Types::String
      attribute :schema, Types::Array do
        attribute :table, Types::String
        attribute :columns, Types::Array do
          attribute :name, Types::String
          attribute :type, Types::String
          attribute :null, Types::Bool.optional
          attribute :default, Types::String.optional
          attribute? :values, Types::Array.optional
        end
        attribute :indices, Types::Array do
          attribute :name, Types::String
          attribute :columns, Types::Array
          attribute :unique, Types::Bool.optional
        end
        attribute? :options do
          attribute? :habtm, Types::Bool.optional
          attribute? :habtm_tables, Types::Array.optional
          attribute? :use_uuid, Types::Bool.optional
        end
      end
      attribute :relationships, Types::Array do
        attribute :type, Types::String
        attribute :source, Types::String
        attribute? :destination, Types::String.optional
        attribute :required, Types::Bool.optional
        attribute? :options do
          attribute? :habtm, Types::Bool.optional
          attribute? :habtm_table, Types::String.optional
          attribute? :habtm_tables, Types::Array.optional
          attribute? :class_name, Types::String.optional
          attribute? :foreign_key, Types::String.optional
          attribute? :dependent, Types::String.optional
          attribute? :through, Types::String.optional
        end
      end
    end
  end
end
