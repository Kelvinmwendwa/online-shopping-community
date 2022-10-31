# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Search, type: :model do
  it 'is created successfully with a search term' do
    search = Search.create(search_term: 'Shoes')
    expect(search).to be_valid
  end

  it { should have_many(:products) }

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:search_term) }
  end
end
