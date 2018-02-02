class CreateActorProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :actor_profiles do |t|
      t.references :actor, foreign_key: true, index: { unique: true }, null: false
      t.date :debuted_on, null: false

      t.timestamps
    end
  end
end
