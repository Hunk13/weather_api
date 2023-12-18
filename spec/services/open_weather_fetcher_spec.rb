require 'rails_helper'

RSpec.describe OpenWeatherFetcher, type: :model do
  let(:city) { 'New York' }
  let(:fetcher) { OpenWeatherFetcher.new(city) }

  describe '#call' do
    context 'when the API request is successful' do
      before do
        stub_request(:get, "#{ENV['OPENWEATHER_HOST']}#{OpenWeatherFetcher::WEATHER_API_PATH}")
          .with(query: { q: city, appid: ENV['OPENWEATHER_TOKEN'], units: 'metric' })
          .to_return(body: { weather_data: 'sunny', code: 200 }.to_json)
      end

      it 'returns the weather data' do
        expect(fetcher.call).to eq("{\"weather_data\":\"sunny\",\"code\":200}")
      end
    end
  end
end
