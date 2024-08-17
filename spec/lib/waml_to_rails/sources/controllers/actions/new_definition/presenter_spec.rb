require 'spec_helper'

RSpec.describe ::WamlToRails::Sources::Controllers::Actions::NewDefinition::Presenter do
  describe '#render' do
    it 'renders the action' do
      expected_definition = <<~RUBY
        def new
          @user = User.new
        end
      RUBY

      expect(
        described_class.new(table_name: 'users').render
      ).to eq(expected_definition)
    end
  end
end
