class AddInternationalBooleanToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :international, :boolean, :default => false
  end
end
