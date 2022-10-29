class CreateValues < ActiveRecord::Migration[6.1]
  def change
    create_table :values do |t|
      t.float :price
      t.string :currency
      t.string :payment_type
      t.integer :article_id
      t.timestamps
    end
  end
end
