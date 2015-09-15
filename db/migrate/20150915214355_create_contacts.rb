class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email_address
      t.integer :country_code
      t.integer :phone_number
      t.string :extension
      t.string :integer
      t.string :company_name

      t.timestamps null: false
    end
  end
end
