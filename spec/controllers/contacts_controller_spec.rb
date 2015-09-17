require 'rails_helper'

describe ContactsController do

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
    it 'creates the best poptart' do
      expect(Contact.count).to eq(0)

      upload_file = fixture_file_upload("data.tsv", "text/tab-separated-values")
      post :create, { contacts: upload_file }

      expect(response).to have_http_status(:found)
      expect(Contact.count).to eq(200)
    end
  end

  context '#destroy' do
    it 'destroys disgusting poptarts' do
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
