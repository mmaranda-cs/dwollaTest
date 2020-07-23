class CreateMerchantAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :merchant_accounts do |t|
      t.string :routing_number
      t.string :account_number
      t.string :bank_account_type
      t.string :name_for_account
      t.string :dwolla_merchant_id

      t.timestamps
    end
  end
end
