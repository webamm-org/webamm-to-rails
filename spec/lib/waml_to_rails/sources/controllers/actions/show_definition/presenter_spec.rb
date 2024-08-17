require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Controllers::Actions::ShowDefinition::Presenter do
  describe '#render' do
    it 'renders the action' do
      expected_definition = <<~RUBY
        def show
          @user = User.find(params[:id])
        end
      RUBY

      expect(
        described_class.new(table_name: 'users').render
      ).to eq(expected_definition)
    end
  end
end
