class FavoriteCitiesFacade
  def initialize(cities)
    @cities = cities
  end

  def forecasts
    forecasts = coordinate_collection.map do |coordinates|
      ForecastService.new(coordinates[0], coordinates[1]).forecast
    end
    city_forecasts = make_city_forecast_objects(forecasts)
    serialize(city_forecasts)
  end

  private
  def coordinate_collection
    @cities.map do |city|
      [ LocationService.new.location(city)[0],
      LocationService.new.location(city)[1] ]
    end
  end

  def make_city_forecast_objects(forecasts)
    @cities.zip(forecasts).map do |city_forecast|
      FavoriteCityForecast.new(city_forecast)
    end
  end

  def serialize(city_forecasts)
    city_forecasts.map do |city_forecast|
      FavoriteCitySerializer.new(city_forecast)
    end
  end
end
