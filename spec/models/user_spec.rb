require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  it "can decode the token for the same user" do
    token = user1.generate_token
    decoded = User.decode_token token

    expect(decoded).not_to be_nil
    expect(decoded['user_id']).to eq(user1.id)
  end

  it "can't find a user if token expires" do
    time_now = Time.now - 2.weeks
    token = nil

    Timecop.freeze(time_now) do
      token = user1.generate_token
    end

    user = User.find_by_token token
    expect(user).to be_nil
  end

  it "can't find a user if token is invalid" do
    user = User.find_by_token 'some_invalid_token'

    expect(user).to be_nil
  end
end
