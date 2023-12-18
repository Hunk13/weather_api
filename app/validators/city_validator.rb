class CityValidator
  def initialize(city)
    @city = city
  end

  def valid?
    CityValidations::PresentValidation.new(city).valid? &&
    CityValidations::CharactersValidation.new(city).valid?
  end

  def error_message
    return 'City must be present.' unless CityValidations::PresentValidation.new(city).valid?
    return 'City contains invalid characters.' unless CityValidations::CharactersValidation.new(city).valid?
  end

  private

  attr_reader :city
end
