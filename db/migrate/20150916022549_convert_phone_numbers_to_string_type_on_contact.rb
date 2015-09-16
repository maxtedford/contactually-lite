class ConvertPhoneNumbersToStringTypeOnContact < ActiveRecord::Migration
  def change
    change_column :contacts, :country_code, :string
    change_column :contacts, :phone_number, :string
    change_column :contacts, :extension, :string
  end
end
