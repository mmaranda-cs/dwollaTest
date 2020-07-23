class CreateDwollaMerchants < ActiveRecord::Migration[5.2]
  def change
    create_table :dwolla_merchants do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :account_type
      t.string :ip_address
      t.string :business_name

      t.timestamps
    end
  end
end
