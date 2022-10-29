class CreateReactions < ActiveRecord::Migration[6.1]
  def change
    create_table :reactions do |t|
      t.integer :likes
      t.boolean :by_user
      t.integer :views
      t.integer :impressions
      t.integer :article_id
      t.timestamps
    end
  end
end
