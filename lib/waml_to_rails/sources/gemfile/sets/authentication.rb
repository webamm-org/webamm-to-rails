module WamlToRails
  module Sources
    module Gemfile
      module Sets
        class Authentication
          def initialize(waml_definition:)
            @waml_definition = waml_definition
          end

          def collection
            return [] if @waml_definition.authentication.blank?

            base_collection = [
              ::WamlToRails::Sources::Gemfile::Gem.new(name: "devise", version: "4.9.4", required: true, group: :default, platforms: [])
            ]

            return base_collection if @waml_definition.authentication.all? { |auth| auth.features.blank? }

            if @waml_definition.authentication.any? { |auth| auth.features.include?('invitations') }
              base_collection << ::WamlToRails::Sources::Gemfile::Gem.new(name: "devise_invitable", version: "2.0.9", required: true, group: :default, platforms: [])
            end

            if @waml_definition.authentication.any? { |auth| auth.features.include?('two_factor_authentication') }
              base_collection << ::WamlToRails::Sources::Gemfile::Gem.new(name: "devise-otp", version: "0.7.1", required: true, group: :default, platforms: [])
            end

            base_collection
          end
        end
      end
    end
  end
end
