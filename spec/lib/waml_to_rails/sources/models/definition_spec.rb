require 'spec_helper'

RSpec.describe WamlToRails::Sources::Models::Definition do
  describe '#render' do
    it 'returns empty class definition' do
      expected_definition = <<~RUBY
        class User < ApplicationRecord

        end
      RUBY

      expect(
        described_class.new(table_name: 'users', waml_definition: {}).render
      ).to eq(expected_definition)
    end
  end
end
