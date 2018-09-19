class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :url

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
