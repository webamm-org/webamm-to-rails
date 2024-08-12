require_relative 'qr_code_helper/presenter'

module WamlToRails
  module Sources
    module Helpers
      module Devise
        class Presenter
          def initialize(waml_definition:)
            @waml_definition = waml_definition
          end

          def collection
            return [] if @waml_definition.authentication.blank?
            return [] unless @waml_definition.authentication.any? { |auth| auth.features.include?('two_factor_authentication') }

            [
              {
                path: 'app/helpers/devise_qr_code_helper.rb',
                content: ::WamlToRails::Sources::Helpers::Devise::QrCodeHelper::Presenter.new.render
              }
            ]
          end
        end
      end
    end
  end
end
