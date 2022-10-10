require "test_helper"

class LocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    weather_json = File.read(
      Rails.root.join('test/fixtures/files/weather_data.json')
    )

    @location = locations(:valid).tap do |l|
      l.weather_data = JSON.parse(weather_json)
    end
  end

  test "should get index" do
    get locations_url
    assert_response :success
  end

  test "should get new" do
    get new_location_url
    assert_response :success
  end

  test "should create location" do
    assert_difference("Location.count") do
      post locations_url, params: {
        location: {
          city: @location.city,
          lat: @location.lat,
          lng: @location.lng,
          postal_code: "12345",
          state: @location.state
        }
      }
    end

    assert_redirected_to location_url(Location.find_by(postal_code: "12345"))
  end

  test "should show location" do
    get location_url(@location)
    assert_response :success
  end
end
