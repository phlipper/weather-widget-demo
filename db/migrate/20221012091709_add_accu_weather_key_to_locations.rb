class AddAccuWeatherKeyToLocations < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :accu_weather_key, :string
  end
end
