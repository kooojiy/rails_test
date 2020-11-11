class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.text :name
      t.text :owner
      t.text :date
      t.text :site
      t.boolean :link

      t.timestamps
    end
  end
end
