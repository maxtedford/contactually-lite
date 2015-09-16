require "rails_helper"

describe "the user", type: :feature do
  context "when visiting the root page" do
    
    before(:each) { visit root_path }
    
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
      attach_file("contacts", "spec/fixtures/data.tsv")
      click_button("upload")
      
      expect(current_path).to eq(contacts_path)
    end
  end
  
  context "when viewing the contacts index page" do
    
    before(:each) do
      visit root_path
      attach_file("contacts", "spec/fixtures/data.tsv")
      click_button("upload")
    end

    it "can see all its contacts" do
      expect(page).to have_content("Gerhard Kautzer (Hodkiewicz-Lynch)")
      expect(page).to have_content("gerhardkautzer@cronabayer.com")
      expect(page).to have_content("1 (207) 643-1816")
      expect(page.all(:css, 'h2').length).to eq(400)
      expect(page.all(:css, 'h4').length).to eq(800)
    end
    
    it "can see a delete button for each contact" do
      expect(page).to have_button("Delete")
      expect(page.all(:css, 'button').length).to eq(400)
    end
  end
end
