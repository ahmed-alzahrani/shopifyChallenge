class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :url
      t.integer :order_count, null: false, default: 0
      t.float :total_sold, null: false, default: 0.00

      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
