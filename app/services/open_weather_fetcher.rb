class OpenWeatherFetcher
  WEATHER_API_PATH = "/data/2.5/weather"

  def initialize(city)
    @city = city
  end

  def call
    WeatherApiClient.new(city, WEATHER_API_PATH, open_weather_api_params).call
  end

  private

  attr_reader :city

  def open_weather_api_params
    { q: city, appid: ENV['OPENWEATHER_TOKEN'], units: 'metric' }
  end
end
