class CreateOwnerScrapings < ActiveRecord::Migration[6.0]
  def change
    create_table :owner_scrapings do |t|

      t.timestamps
    end
  end
end
