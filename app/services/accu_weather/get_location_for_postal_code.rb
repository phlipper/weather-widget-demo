module AccuWeather
  class GetLocationForPostalCode < Base
    API_PATH = "/locations/v1/postalcodes/search"

  private

    def filter_result(result)
      result.find { |location| location.dig("Country", "ID") == "US" }
    end

    def parse_result(result)
      hash = JSON.parse(result)
      raise AccuWeather::LocationNotFound if hash.blank?

      data = filter_result(hash)
      raise AccuWeather::LocationNotFound if data.blank?

      Location.new(
        data["LocalizedName"],
        data["Key"],
        data["GeoPosition"]["Latitude"],
        data["GeoPosition"]["Longitude"],
        data["AdministrativeArea"]["LocalizedName"]
      )
    end

    def uri
      @uri ||= begin
        params = {
          apikey: ENV.fetch("ACCU_WEATHER_API_KEY"),
          language: "en-us",
          q: @identifier,
        }.to_query

        URI("#{BASE_URL}/#{API_PATH}?#{params}")
      end
    end
  end
end
