class CreateTransferFunds < ActiveRecord::Migration[5.2]
  def change
    create_table :fund_transfer do |t|
      t.string :target_account_id
      t.string :source_account_id
      t.string :transfer_total

      t.timestamps
    end
  end
end
