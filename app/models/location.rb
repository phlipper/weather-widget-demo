class Location < ApplicationRecord
  before_create :set_weather_data

  validates :city, :state, :lat, :lng, presence: true
  validates :postal_code, length: { is: 5 }, presence: true, uniqueness: true

  def to_param
    postal_code
  end

  def weather
    @weather ||= begin
      if weather_data.present?
        JSON.parse(weather_data.to_json, object_class: OpenStruct)
      else
        nil
      end
    end
  end

private

  def set_weather_data
    self.weather_data = GetWeatherForLocation.(self)
    self.weather_updated_at = Time.now
  end
end
