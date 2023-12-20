class Api::V1::WeatherController < Api::V1::BaseController
  before_action :validate_city, only: :show

  def show
    performance_monitor.track_request do
      render json: fetch_weather
    end
  end

  private

  def fetch_weather
    OpenWeatherFetcher.new(city).call
  end

  def city
    params[:city]
  end

  def validate_city
    validator = CityValidator.new(city)

    unless validator.valid?
      render json: { message: validator.error_message, code: 406 }, status: :not_acceptable
    end
  end
end
