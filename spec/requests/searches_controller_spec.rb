# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  describe '#create_or_find_by' do
    search = Search.create(search_term: '')
  end
end
