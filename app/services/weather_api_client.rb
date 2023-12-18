class WeatherApiClient
  def initialize(city, api_path, api_params)
    @city = city
    @api_path = api_path
    @api_params = api_params
  end

  def call
    response_body
  end

  private

  attr_reader :city, :api_path, :api_params

  def response_body
    response.body
  end

  def response
    Rails.cache.fetch("#{city}", expires_in: 4.hours) do
      begin
        weather_connection
      rescue Faraday::Error => e
        OpenStruct.new(body: { code: 406, message: e })
      end
    end
  end

  def weather_connection
    connection.get(api_path, api_params)
  end

  def connection
    @connection ||= Faraday.new(
      url: ENV['OPENWEATHER_HOST'],
      headers: { 'Content-Type' => 'application/json' }
    )
  end
end
