class UpdateDwollaMerchants < ActiveRecord::Migration[5.2]
  def change
    add_column :dwolla_merchants, :merchant_account_id, :string
  end
end

