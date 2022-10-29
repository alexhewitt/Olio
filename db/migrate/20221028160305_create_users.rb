class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.text :roles, array: true, default: []
      t.json :rating
      t.json :verifications
      t.text :current_avatar, array: true, default: []
      t.timestamps
    end
  end
end
