require "test_helper"

class LocationTest < ActiveSupport::TestCase
  def setup
    @location = locations(:valid)
    @invalid = Location.new
  end

  test "valid location" do
    assert @location.valid?
  end

  test "invalid without postal_code" do
    @location.postal_code = nil
    refute @location.valid?
    assert_not_nil @location.errors[:postal_code]
  end

  test "invalid with incorrect postal_code" do
    @location.postal_code = "123"
    refute @location.valid?
    assert_not_nil @location.errors[:postal_code]

    @location.postal_code = "123456"
    refute @location.valid?
    assert_not_nil @location.errors[:postal_code]
  end

  test "invalid without city" do
    @location.city = nil
    refute @location.valid?
    assert_not_nil @location.errors[:city]
  end

  test "invalid without state" do
    @location.state = nil
    refute @location.valid?
    assert_not_nil @location.errors[:state]
  end

  test "invalid without lat" do
    @location.lat = nil
    refute @location.valid?
    assert_not_nil @location.errors[:lat]
  end

  test "invalid without lng" do
    @location.lng = nil
    refute @location.valid?
    assert_not_nil @location.errors[:lng]
  end

  test "invalid without accu_weather_key" do
    @location.accu_weather_key = nil
    refute @location.valid?
    assert_not_nil @location.errors[:accu_weather_key]
  end

  test "to_param" do
    assert_equal @location.postal_code, @location.to_param
  end
end
