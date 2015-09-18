require "rails_helper"

describe "the user", type: :feature do
  context "when visiting the root page" do
    
    before(:each) {
      DatabaseCleaner.start
      DatabaseCleaner.clean
      visit root_path
    }
    
    it "can see a welcome message" do
      expect(page).to have_content("Welcome to Contactually-Lite!")
    end
    
    it "can see a file upload invitation" do
      expect(page).to have_content("Upload your contacts here:")
    end
    
    it "can see an input field for contacts" do
      expect(page).to have_css('input[type="file"]')
    end
    
    it "can see a submit button" do
      expect(page).to have_button("upload")
    end
    
    it "can post the file" do
      attach_file("contacts_file", "spec/fixtures/data.tsv")
      click_button("upload")
      
      expect(current_path).to eq(contacts_path)
      expect(Contact.count).to eq(200)
    end
  end
end
