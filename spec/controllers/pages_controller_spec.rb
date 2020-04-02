require 'rails_helper'

RSpec.describe PagesController, type: :request do
  before do
    host! 'thinkfic.example.com'
  end

  describe "GET /" do
    context "When the user is not logged in" do
      it "should present the necessary login functions" do
        get '/'

        expect(response).to have_http_status(:success)
        expect(response.body).to include "users/sign_in"
        expect(response.body).to include "users/sign_up"
        expect(response.body).to include "facebook"
      end
    end

    context "When the user is logged in" do
      let(:user) { create(:user) }

      before do
        allow_any_instance_of(described_class)
          .to receive(:current_user)
          .and_return(user)
      end

      it "should present logout function" do
        get '/'

        expect(response).to have_http_status(:success)
        expect(response.body).to_not include "users/sign_in"
        expect(response.body).to_not include "users/sign_up"
        expect(response.body.downcase).to include "logout"
      end
    end

  end

end
