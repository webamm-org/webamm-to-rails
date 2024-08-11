module WamlToRails
  module Sources
    module Models
      class DeviseDefinition
        class Presenter
          def initialize(table_name:, waml_definition:)
            @table_name = table_name
            @waml_definition = waml_definition
          end

          def render
            return unless authenticated?

            base_strategies = [
              'database_authenticatable', 'validatable', 'rememberable', 'recoverable', 'trackable'
            ]

            if auth_features.include?('allow_sign_up')
              base_strategies << 'registerable'
              base_strategies << 'confirmable'
            end

            if auth_features.include?('invitations')
              base_strategies << 'invitable'
            end

            if auth_features.include?('two_factor_authentication')
              base_strategies << 'otp_authenticatable'
            end

            "devise #{base_strategies.map { |strategy| ":#{strategy}" }.join(', ')}"
          end

          private

          def authenticated?
            return false if @waml_definition.authentication.blank?

            @waml_definition.authentication.map(&:table).include?(@table_name)
          end

          def auth_features
            @waml_definition.authentication.find { |auth| auth.table == @table_name }.features
          end
        end
      end
    end
  end
end
