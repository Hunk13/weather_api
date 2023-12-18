module CityValidations
  class PresentValidation
    def initialize(city)
      @city = city
    end

    def valid?
      @city.present?
    end
  end
end
