class Location < ApplicationRecord
  WEATHER_CACHE_EXPIRY = 30.minutes

  attribute :weather_is_cached, :boolean, default: false

  validates :city, :state, :lat, :lng, presence: true
  validates :postal_code, length: { is: 5 }, presence: true, uniqueness: true

  def self.lookup(postal_code)
    location = find_by!(postal_code: postal_code)

    if location.weather_is_fresh?
      return location.tap do |l|
        l.weather_is_cached = true
      end
    end

    location.tap do |l|
      l.send(:set_weather_data)
      l.save!
    end
  end

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

  def weather_is_fresh?
    weather_data.present? &&
      weather_updated_at.present? &&
      weather_updated_at > WEATHER_CACHE_EXPIRY.ago
  end

private

  def set_weather_data
    self.weather_data = GetWeatherForLocation.(self)
    self.weather_updated_at = Time.now
  end
end
