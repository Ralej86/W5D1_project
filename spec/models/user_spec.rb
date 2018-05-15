require 'rails_helper'

RSpec.describe User, type: :model do

  # subject(:user1) {User.new(username: 'U1', password: 'abcdef')}
  subject(:user1) { FactoryBot.build(:user)}

  #validations
  #class methods
  describe "validations" do
    it { should validate_presence_of(:username)}
    it { should validate_presence_of(:password_digest)}
    it { should validate_presence_of(:session_token)}
    it { should validate_uniqueness_of(:username)}
    it { should validate_uniqueness_of(:session_token)}
    it { should validate_length_of(:password).is_at_least(6)}
  end

  # describe "associations" do
  #
  # end

  describe "class_methods" do

    describe "::find_by_credentials" do
      it 'finds user by username and password' do
        # expect(User).to receive(:self.find_by_credentials).with(username, password)
        expect(User.find_by_credentials(user1.username, user1.password)).to eq(user1)
      end

      it 'returns nil given bad credentials' do
        expect(User.find_by_credentials(user1.username, 'notmypassword')).to eq(nil)
      end
    end

  describe "#is_password?" do
    it 'returns true with correct password' do
      expect(user1.is_password?(user1.password)).to be true
    end
    it 'returns false with incorrect password' do
      expect(user1.is_password?('abc')).to be false
    end
  end

  # describe "#password=" do
  #   it 'does not store password in db' do
  #     expect(user1.password).to eq(nil)
  #   end
  # end

  describe "#reset_session_token!" do
    it 'sets a new session token on the user' do
      user1.valid?
      old_token = user1.session_token
      user1.reset_session_token!
      expect(user1.session_token).to_not eq(old_token)
    end
    it 'returns the new session token' do
      expect(user1.reset_session_token!).to eq(user1.session_token)
    end
  end


  end
end
