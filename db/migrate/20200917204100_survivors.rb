class Survivors < ActiveRecord::Migration[6.0]
  def change
    create_table :survivors do |t|
      t.string :name
      t.integer :age
      t.integer :gender
      t.decimal :latitude, :precision=>10, :scale=>6
      t.decimal :longitude, :precision=>10, :scale=>6
      t.boolean :infected, :default=> false
      t.timestamps
    end
  end
end
