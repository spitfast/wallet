# frozen_string_literal: true

require 'spec_helper'

describe Stock do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
