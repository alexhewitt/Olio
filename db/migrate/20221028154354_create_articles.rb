class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.string :section
      t.string :status
      t.boolean :is_owner
      t.string :collection_notes
      t.string :image
      t.integer :user_id
      t.timestamps
    end
  end
end
