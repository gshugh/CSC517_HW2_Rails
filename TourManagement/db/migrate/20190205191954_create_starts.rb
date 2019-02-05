class CreateStarts < ActiveRecord::Migration[5.2]
  def change
    create_table :starts do |t|
      t.references :tour, foreign_key: true
      t.references :location, foreign_key: true

      t.timestamps
    end
  end
end
