class CreateArtistProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :artist_profiles do |t|
      t.references :artist, foreign_key: true, index: { unique: true }, null: false
      t.date :debuted_on, null: false

      t.timestamps
    end
  end
end
