require "rails_helper"

RSpec.describe UserSearch, type: :model do
    it{should belong_to(:user)}
    it{should belong_to(:search)}
end