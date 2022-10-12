module AccuWeather
  class GetForecastForLocationKey < Base
    API_PATH = "/forecasts/v1/daily/5day"

  private

    def parse_result(result)
      JSON.parse(result)
    end

    def uri
      @uri ||= begin
        params = {
          apikey: ENV.fetch("ACCU_WEATHER_API_KEY"),
          details: true,
          language: "en-us",
        }.to_query

        URI("#{BASE_URL}#{API_PATH}/#{@identifier}?#{params}")
      end
    end
  end
end
