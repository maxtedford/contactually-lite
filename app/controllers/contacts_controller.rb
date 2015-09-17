require 'csv'
require 'phone'

class ContactsController < ApplicationController
  
  def index
    @contacts = Contact.all
  end
  
  def create
    Phoner::Phone.default_country_code = '1'
    tsv_file = Parser.new(params[:contacts]).set_tsv
    tsv_file.each do |row|
      pn = Phoner::Phone.parse(Normalizer.new(row[:phone_number]).internationalize)
      Contact.create!(first_name:    row[:first_name],
                      last_name:     row[:last_name],
                      email_address: row[:email_address],
                      country_code:  pn.format("%c"),
                      phone_number:  pn.format("(%a) %f-%l"),
                      extension:     pn.format("%x"),
                      company_name:  row[:company_name],
                      international: check_international(row))
    end
    redirect_to contacts_path
  end
  
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to contacts_path
  end
  
  private
  
  def check_international(row)
    normalized = Normalizer.new(row[:phone_number]).normalize
    normalized.gsub(/x.*/, "").length > 10 ? true : false
  end
end
