require 'rails_helper'

RSpec.describe Api::V1::WeatherController, type: :controller do
  let(:city) { 'New York' }

  describe 'GET #show' do
    context 'when the city is valid' do
      before do
        allow_any_instance_of(CityValidator).to receive(:valid?).and_return(true)
        allow_any_instance_of(OpenWeatherFetcher).to receive(:call).and_return('weather_data')
        get :show, params: { city: city }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the city is invalid' do
      before do
        allow_any_instance_of(CityValidator).to receive(:valid?).and_return(false)
        allow_any_instance_of(CityValidator).to receive(:error_message).and_return('Invalid city')
        get :show, params: { city: city }
      end

      it 'returns http status not_acceptable' do
        expect(response).to have_http_status(:not_acceptable)
      end

      it 'returns an error message' do
        expect(JSON.parse(response.body)).to eq({ 'message' => 'Invalid city', 'code' => 406 })
      end
    end
  end
end
