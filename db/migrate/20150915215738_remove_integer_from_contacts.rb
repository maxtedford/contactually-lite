class RemoveIntegerFromContacts < ActiveRecord::Migration
  def change
    remove_column :contacts, :integer
    remove_column :contacts, :extension
    add_column :contacts, :extension, :integer
  end
end
