class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :qty
      t.string :first
      t.string :last
      t.string :city
      t.string :country
      t.string :cardholder
      t.string :card
      t.string :expiry_month
      t.string :expiry_year
      t.string :cvv

      t.timestamps null: false
    end
  end
end
