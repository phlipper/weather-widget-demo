require "net/http"
require "net/https"
require "ostruct"

class GetWeatherForLocation
  BASE_URL = "https://api.openweathermap.org/data/3.0/onecall"

  def self.call(location)
    new(location).call
  end

  def initialize(location)
    @location = location
  end

  def call
    JSON.parse(get_result)
  end

private

  def get_result
    # Create client
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # Create Request
    request = Net::HTTP::Get.new(uri)

    # Fetch Request
    result = http.request(request)
    result.body
  end

  def uri
    @uri ||= begin
      params = {
        appid: ENV.fetch("OPEN_WEATHER_API_KEY"),
        exclude: "alerts,minutely",
        lat: @location.lat,
        lon: @location.lng,
        units: "imperial",
      }.to_query

      URI("#{BASE_URL}?#{params}")
    end
  end
end
