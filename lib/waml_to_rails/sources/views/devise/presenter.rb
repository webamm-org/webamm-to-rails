require_relative 'otp/presenter'
require_relative 'invitable/presenter'
require_relative 'standard/presenter'

module WamlToRails
  module Sources
    module Views
      module Devise
        class Presenter
          def initialize(waml_definition:)
            @waml_definition = waml_definition
          end

          def collection
            return [] if @waml_definition.authentication.blank?

            views_collection = []

            @waml_definition.authentication.each do |authentication|
              views_collection |= ::WamlToRails::Sources::Views::Devise::Standard::Presenter.new(table_name: authentication.table).collection

              if authentication.features.include?('invitations')
                views_collection |= ::WamlToRails::Sources::Views::Devise::Invitable::Presenter.new(table_name: authentication.table).collection
              end
            end

            if @waml_definition.authentication.any? { |authentication| authentication.features.include?('two_factor_authentication') }
              views_collection |= ::WamlToRails::Sources::Views::Devise::Otp::Presenter.new.collection
            end

            views_collection
          end
        end
      end
    end
  end
end
