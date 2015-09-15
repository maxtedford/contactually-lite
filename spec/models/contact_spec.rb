require 'rails_helper'

RSpec.describe Contact, type: :model do
  context "model creation" do
    
    let(:valid_attributes) { { first_name: "john", 
                               last_name: "smith", 
                               email_address: "johnsmith@fake.com", 
                               country_code: 1, 
                               phone_number: 1234567890, 
                               extension: 555, 
                               company_name: "john smith ltd." } }
    
    it "is valid" do
      contact = Contact.create(valid_attributes)
      
      expect(contact).to be_valid
    end
    
    it "is invalid without a first_name" do
      contact = Contact.create(last_name: "smith",
                               email_address: "johnsmith@fake.com",
                               country_code: 1,
                               phone_number: 1234567890,
                               extension: 555,
                               company_name: "john smith ltd.")
      
      expect(contact).not_to be_valid
    end
    
    it "is invalid without a last name" do
      contact = Contact.create(first_name: "john",
                               email_address: "johnsmith@fake.com",
                               country_code: 1,
                               phone_number: 1234567890,
                               extension: 555,
                               company_name: "john smith ltd.")

      expect(contact).not_to be_valid
    end
    
    it "is invalid without an email address" do
      contact = Contact.create(first_name: "john",
                               last_name: "smith",
                               country_code: 1,
                               phone_number: 1234567890,
                               extension: 555,
                               company_name: "john smith ltd.")
      
      expect(contact).not_to be_valid
    end
    
    it "can still be valid without a country code" do
      contact = Contact.create(first_name: "john",
                               last_name: "smith",
                               email_address: "johnsmith@fake.com",
                               phone_number: 1234567890,
                               extension: 555,
                               company_name: "john smith ltd.")
      
      expect(contact).to be_valid
    end
    
    it "is invalid without a phone number" do
      contact = Contact.create(first_name: "john",
                               last_name: "smith",
                               email_address: "johnsmith@fake.com",
                               country_code: 1,
                               extension: 555,
                               company_name: "john smith ltd.")
      
      expect(contact).not_to be_valid
    end
    
    it "can still be valid without an extension" do
      contact = Contact.create(first_name: "john",
                               last_name: "smith",
                               email_address: "johnsmith@fake.com",
                               country_code: 1,
                               phone_number: 1234567890,
                               company_name: "john smith ltd.")
      
      expect(contact).to be_valid
    end
    
    it "is invalid without a company name" do
      contact = Contact.create(first_name: "john",
                               last_name: "smith",
                               email_address: "johnsmith@fake.com",
                               country_code: 1,
                               phone_number: 1234567890,
                               extension: 555)
      
      expect(contact).not_to be_valid
    end
  end
end
