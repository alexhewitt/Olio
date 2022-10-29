class AddColumnToAddress < ActiveRecord::Migration[6.1]
  def change
    add_column :addresses, :locatable_type, :string
  end
end
