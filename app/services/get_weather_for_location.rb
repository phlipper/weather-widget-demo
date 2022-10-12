class GetWeatherForLocation
  def self.call(location)
    new(location).call
  end

  def initialize(location)
    @location = location
  end

  def call
    AccuWeather::GetForecastForLocationKey.(@location.accu_weather_key)
  end
end
