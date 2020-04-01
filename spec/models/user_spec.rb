require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User JWT token functions' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }

    it "can decode the token for the same user" do
      token = user1.generate_token
      decoded = user1.decode_token token

      expect(decoded).not_to be_nil
      expect(decoded['user_id']).to eq(user1.id)
    end

    it "fails when the token is from another user" do
      token = user1.generate_token

      expect{user2.decode_token token}.to raise_error "Token user_id invalid"
    end

    it "fails when the token expires" do
      @time_now = Time.now - 2.weeks
      token = nil

      Timecop.freeze(@time_now) do
        token = user1.generate_token
      end

      expect{user1.decode_token token}.to raise_error(RuntimeError, /has expired at/)
    end
  end
end
