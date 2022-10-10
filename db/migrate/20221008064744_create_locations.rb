class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    enable_extension "pgcrypto" unless extension_enabled?("pgcrypto")

    create_table :locations, id: :uuid do |t|
      t.string :city, null: false
      t.string :state, null: false
      t.string :postal_code, index: true, limit: 5, null: false, unique: true
      t.decimal :lat, null: false, precision: 10, scale: 6
      t.decimal :lng, null: false, precision: 10, scale: 6

      t.timestamps
    end
  end
end
