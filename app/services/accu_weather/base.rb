require "net/http"

module AccuWeather
  class Base
    BASE_URL = "https://dataservice.accuweather.com"

    def self.call(identifier)
      new(identifier).call
    end

    def initialize(identifier)
      @identifier = identifier
    end

    def call
      get_result(uri)
    end

  private

    def fetch_result(uri)
      # Create client
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER

      # Create Request
      request = Net::HTTP::Get.new(uri)

      # Headers
      request["Accept"] = "application/json"
      request["Cache-Control"] = "no-cache"
      request["Pragma"] = "no-cache"
      request["User-Agent"] = "Weather API Demo Project"

      # Fetch Request
      result = http.request(request)
      result.body
    end

    def get_result(uri)
      result = fetch_result(uri)
      parse_result(result)
    end

    def parse_result(result)
      raise NotImplementedError
    end

    def uri
      raise NotImplementedError
    end
  end
end
