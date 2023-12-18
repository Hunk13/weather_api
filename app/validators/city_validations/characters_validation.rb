module CityValidations
  class CharactersValidation
    def initialize(city)
      @city = city
    end

    def valid?
      @city.match?(/^[\p{Letter}\p{Mark}\s-]+$/u)
    end
  end
end
