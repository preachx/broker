class CreateUserAttributes < ActiveRecord::Migration
  def change
    create_table :user_attributes do |t|

      t.integer :user_id
      t.string :vat_number
      t.string :cst_number
      t.string :pan_number
      t.string :bank_name
      t.string :bank_branch
      t.string :bank_account_number
      t.string :bank_rtgs_code
      t.string :station
      t.string :primary_address_id

      t.timestamps
    end

    add_attachment :user_attributes, :cancelled_cheque_photo

    add_index :user_attributes, :user_id, unique: true
  end
end
