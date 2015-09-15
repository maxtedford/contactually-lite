require "rails_helper"

describe "the user", type: :feature do
  context "when visiting the root page" do
    
    before(:each) { visit root_path }
    
    it "will see a welcome message" do
      expect(page).to have_content("Welcome to Contactually-Lite!")
    end
    
    it "will see a file upload invitation" do
      expect(page).to have_content("Upload your contacts here:")
    end
    
    it "will see an input field for contacts" do
      expect(page).to have_css('input[type="file"]')
    end
    
    it "will see a submit button" do
      expect(page).to have_button("upload")
    end
  end
end
