class CreateOwners < ActiveRecord::Migration[6.0]
  def change
    create_table :owners do |t|
      t.text :name
      t.integer :owner_id
      t.text :site

      t.timestamps
    end
  end
end
