module ApplicationHelper
  def google_api_url
    params = {
      callback: "initGoogleApi",
      key: ENV.fetch("GOOGLE_API_KEY"),
      libraries: "places",
    }.to_query

    "https://maps.googleapis.com/maps/api/js?#{params}"
  end
end
