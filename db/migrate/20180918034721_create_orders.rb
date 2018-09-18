class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.timestamp :created
      t.float :subTotal
      t.float :savings
      t.float :tax
      t.float :total

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
