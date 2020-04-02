require 'rails_helper'

RSpec.describe V1::CountersController, type: :request do
  let(:user) { create(:user) }
  let(:secret_key) { user.generate_token }
     
  let(:authenticated_headers) { { 'Authorization': "Bearer #{secret_key}" } }

  before do
    host! 'test.example.com'
  end

  describe 'GET /v1/next' do
    def perform_request!(headers: nil)
      get '/v1/next', headers: headers
    end

    context 'when user is not authenticated' do
      before do
        GlobalCounter.create(name: 'current_int')
      end

      it 'should receive a 401 unauthorized' do
        perform_request!

        expect(response).to have_http_status :unauthorized
      end

      it 'should not change the current_int' do
        expect{ perform_request! }
          .to_not change{ GlobalCounter.find_by(name: 'current_int').value}
      end
    end

    context 'when user is authenticated' do
      before do
        GlobalCounter.create(name: 'current_int')
      end

      it 'should receive the current_int' do
        perform_request!(headers: authenticated_headers)

        expect(response).to have_http_status :ok
        expect(json['data'].keys).to contain_exactly 'current_int' 
      end

      it 'should not change the current_int' do
        expect{ perform_request!(headers: authenticated_headers) }
          .to change{ GlobalCounter.find_by(name: 'current_int').value}.by(1)
      end
    end
  end
end



