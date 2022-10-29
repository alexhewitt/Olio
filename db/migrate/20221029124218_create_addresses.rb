class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :town
      t.string :country
      t.bigint :locatable_id
      t.geometry :location
      t.timestamps
    end
  end
end
