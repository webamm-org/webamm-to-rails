module WebammToRails
  module Sources
    module Controllers
      module ApplicationController
        module Authentication
          module DeviseGroups
            class Presenter
              def initialize(waml_definition:)
                @waml_definition = waml_definition
              end

              def mappings
                group_count = 1
                devise_mappings = {}

                groups.each do |group|
                  if group.size == 1
                    devise_mappings[group] = group.first
                  else
                    devise_mappings[group] = "group#{group_count}"
                    group_count += 1
                  end
                end

                devise_mappings
              end

              private

              def groups
                @groups ||= begin
                  _groups = Set.new

                  @waml_definition.database.crud.each do |crud|
                    crud.actions.each do |action|
                      _groups.add(action.options.authentication)
                    end
                  end

                  _groups.compact_blank
                end
              end
            end
          end
        end
      end
    end
  end
end
