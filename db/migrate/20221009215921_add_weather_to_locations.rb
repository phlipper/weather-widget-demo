class AddWeatherToLocations < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :weather_data, :jsonb, null: false, default: {}
    add_column :locations, :weather_updated_at, :datetime
  end
end
