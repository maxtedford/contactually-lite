require 'csv'
require 'phone'

class ContactsController < ApplicationController
  
  def index
    @contacts = Contact.all
  end
  
  def create
    Phoner::Phone.default_country_code = '1'
    set_tsv(params[:contacts]).each do |row|
      pn = Phoner::Phone.parse(internationalize(row[:phone_number]))
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
  end
  
  private
  
  def normalize(pn)
    pn.gsub(/[^0-9A-Za-z]/, '')
  end

  def set_tsv(params)
    file_path = params.tempfile.to_path.to_s
    text = File.read(file_path, {encoding: "UTF-8"})
    CSV.parse(text, headers: true, header_converters: :symbol, col_sep: "\t")
  end
  
  def check_international(row)
    normalized = normalize(row[:phone_number])
    normalized.gsub(/x.*/, "").length > 10 ? true : false
  end
  
  def internationalize(pn)
    normalized = normalize(pn)
    if (normalized.length > 10 && !normalized.include?("x")) || (normalized.length > 10 && normalized.first == "1")
      "+" << pn
    elsif normalized.first == "0"
      "+1" << pn
    else
      pn
    end
  end
  
  helper_method :check_international
end
