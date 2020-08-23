require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'validations' do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :friend_id }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to(:friend).class_name('User') }
  end

  describe 'methods' do
    before :each do
      @user_1 = User.create!(user_id: "100000000000000000000", name: "John Smith", email: "john@example.com")
      @user_2 = User.create!(user_id: "100000000000000000001", name: "Jane Doe", email: "jane@example.com")
    end

    it "#create_reciprocal_for_ids" do
      expect(Friendship.all.size).to eq(0)
      Friendship.create_reciprocal_for_ids(@user_1.id, @user_2.id)
      expect(Friendship.all.size).to eq(2)
    end

    it "#destroy_reciprocal_for_ids" do
      Friendship.create_reciprocal_for_ids(@user_1.id, @user_2.id)
      expect(Friendship.all.size).to eq(2)
      Friendship.destroy_reciprocal_for_ids(@user_1.id, @user_2.id)
      expect(Friendship.all.size).to eq(0)
    end
  end
end
