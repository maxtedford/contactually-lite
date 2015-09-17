require 'rails_helper'

describe ContactsController, type: :controller do

  before(:each) do
    DatabaseCleaner.start
    DatabaseCleaner.clean
  end
  
  context '#index' do
    it 'returns all the contacts' do
      Contact.create(
        first_name: "john",
        last_name: "smith",
        email_address: "johnsmith@fake.com",
        country_code: "1",
        phone_number: "1234567890",
        extension: "555",
        company_name: "john smith ltd.",
        international: true
      )

      get :index

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
      expect(("li").length).not_to eq(0)
    end
  end
  
  context '#create' do
    it 'creates the contacts' do
      expect(Contact.count).to eq(0)

      upload_file = fixture_file_upload("data.tsv", "text/tab-separated-values")
      post :create, { contacts: upload_file }
      first_contact = Contact.first
      twentieth_contact = Contact.find(20)

      expect(response).to have_http_status(:found)
      expect(Contact.count).to eq(200)
      expect(first_contact.first_name).to eq("Gerhard")
      expect(first_contact.last_name).to eq("Kautzer")
      expect(first_contact.company_name).to eq("Hodkiewicz-Lynch")
      expect(first_contact.email_address).to eq("gerhardkautzer@cronabayer.com")
      expect(first_contact.country_code).to eq("1")
      expect(first_contact.phone_number).to eq("(207) 643-1816")
      expect(first_contact.extension).to eq("")
      expect(first_contact.international).to be_truthy
      expect(twentieth_contact.first_name).to eq("Kaycee")
      expect(twentieth_contact.country_code).to eq("1")
      expect(twentieth_contact.international).to be_falsey
    end
  end

  context '#destroy' do
    it 'destroys unwanted contacts' do
      contact = Contact.create(
        first_name: "john",
        last_name: "smith",
        email_address: "johnsmith@fake.com",
        country_code: "1",
        phone_number: "1234567890",
        extension: "555",
        company_name: "john smith ltd.",
        international: true
      )

      expect {
        delete :destroy, id: contact.id
      }.to change { Contact.count }.from(1).to(0)

      expect(response).to have_http_status(:found)
    end
  end
end
