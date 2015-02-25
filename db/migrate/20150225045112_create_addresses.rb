class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|

      t.integer :user_id
      t.string :address_line_1, maximum: 255
      t.string :address_line_2, maximum: 255
      t.string :city, maximum: 20
      t.string :state, maximum: 20
      t.string :postal_code, maximum: 6
      t.string :mobile_number, maximum: 10
      t.string :landline_number, maximum: 11

      t.timestamps
    end
  end
end
