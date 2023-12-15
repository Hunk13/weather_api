require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    before do
      get :index
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns JSON response with message OK' do
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('OK')
    end
  end
end
