require 'csv'

class ContactsController < ApplicationController
  
  def index
  end
  
  def create
    file_path = params[:contacts].tempfile.to_path.to_s
    text = File.read(file_path, {encoding: "UTF-8"})
    tsv_contacts = CSV.parse(text, headers: true, header_converters: :symbol, col_sep: "\t")
    tsv_contacts.each do |row|
      Contact.create!(first_name:    row[:first_name],
                      last_name:     row[:last_name],
                      email_address: row[:email_address],
                      phone_number:  row[:phone_number],
                      company_name:  row[:company_name])
    end
    redirect_to contacts_path
  end
end
