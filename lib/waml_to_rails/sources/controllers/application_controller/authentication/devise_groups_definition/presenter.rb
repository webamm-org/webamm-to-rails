module WamlToRails
  module Sources
    module Controllers
      module ApplicationController
        module Authentication
          module DeviseGroupsDefinition
            class Presenter
              def initialize(devise_mappings:)
                @devise_mappings = devise_mappings
              end

              def collection
                base_collection = []

                @devise_mappings.each_pair do |group, group_name|
                  next if group.size == 1

                  contains_def = group.map { |group_el| ":#{group_el.singularize}" }.join(', ')
                  base_collection << "devise_group :#{group_name}, contains: [#{contains_def}]"
                end

                base_collection
              end
            end
          end
        end
      end
    end
  end
end
