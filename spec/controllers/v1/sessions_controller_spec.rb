require 'rails_helper'

RSpec.describe V1::SessionsController, type: :request do
  let(:user) { create(:user) }

  before do
    host! 'test.example.com'
  end

  describe "POST /v1/sessions" do
    def perform_request!(params)
      post '/v1/sessions', :params => params 
    end

    it "should return a token when the user exists" do
      params = {
        'email' => user.email,
        'password' => user.password
      }
      perform_request! params

      expect(json['data'].keys).to contain_exactly 'token', 'email'
    end

    it "should return 401 unauthorized when password is wrong" do
      params = {
        'email' => user.email,
        'password' => "wrongpass"
      }
      perform_request! params

      expect(response).to have_http_status :unauthorized
      expect(json['errors']).to be_present
    end
  end
end



