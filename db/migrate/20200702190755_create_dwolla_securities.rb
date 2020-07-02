class CreateDwollaSecurities < ActiveRecord::Migration[5.2]
  def change
    create_table :dwolla_securities do |t|
      t.string :target
      t.string :key
      t.string :secret

      t.timestamps
    end
  end
end
