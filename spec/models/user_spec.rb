# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'creates a user successfully with valid data' do
    user = User.create(name: 'Sam Pull', username: 'sam_pull', email: 'donjoe@gmail.com', password: 'supersEcret',
                       password_confirmation: 'supersEcret', location: 'Nairobi')
    expect(user).to be_valid
  end

  # validations
  describe 'validations' do
    it { is_expected.to validate_presence_of(:password) }
  end
  # login successfully
  it 'is valid if password and password_confirmation match' do
    user = User.new(name: 'Sam Pull', username: 'sam_pull', email: 'donjoe@gmail.com')
    user.password = 'supersEcret'
    user.password_confirmation = 'supersEcret'
    expect(user.valid?).to be(true)
  end

  it 'is valid if password is set and password_confirmation is nil' do
    user = User.new(name: 'Sam Pull', username: 'sam_pull', email: 'donjoe@gmail.com')
    user.password = 'supersEcret'
    expect(user.valid?).to be(true)
  end

  # email verification
end
