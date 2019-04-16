class Api::V1::FavoritesController < ApiController
  def create
    user = User.find_by(api_key: json_body[:api_key])
    if user
      FavoriteCity.create(user: user, city: json_body[:location])
    else
      render json: {}, status: 401
    end
  end

  def index
    user = User.find_by(api_key: json_body[:api_key])
    binding.pry
    if user
      fav_cities_forecasts = FavoriteCitiesFacade.new(extract_city_names(user)).forecasts
      binding.pry
      render json: FavoriteCitiesSerializer.new(fav_cities_forecasts)
    else
      render json: {}, status: 401
    end
  end

  private
  def json_body
    JSON.parse(request.raw_post, symbolize_names: true)
  end

  def extract_city_names(user)
    binding.pry
    user.favorite_cities.map do |fav_city|
      binding.pry
      fav_city.city
    end.uniq
  end
end
