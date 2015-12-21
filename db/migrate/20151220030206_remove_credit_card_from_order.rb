class RemoveCreditCardFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :cardholder
    remove_column :orders, :card
    remove_column :orders, :expiry_month
    remove_column :orders, :expiry_year
    remove_column :orders, :cvv
  end
end
