require "rails_helper"

describe "the user", type: :feature do
  context "when viewing his/her contacts" do
    
    before(:each) {
      DatabaseCleaner.start
      DatabaseCleaner.clean
      visit root_path
      attach_file("contacts", Rails.root.join("spec/fixtures/data.tsv"))
      click_button("upload")
    }
    
    it "can see all his/her contacts" do
      expect(page).to have_content("Gerhard Kautzer (Hodkiewicz-Lynch)")
      expect(page).to have_content("gerhardkautzer@cronabayer.com")
      expect(page).to have_content("1 (207) 643-1816")
      expect(page.all(:css, 'h2').length).to eq(200)
      expect(page.all(:css, 'h4').length).to eq(400)
    end

    it "can see a delete button for each contact" do
      expect(page).to have_button("Delete")
      expect(page.all(:css, 'button').length).to eq(200)
    end
    
    xit "can delete a contact by clicking the delete button" do
      expect(page.all(:css, 'button').length).to eq(200)
      expect(Contact.count).to eq(200)
      expect(all(".delete-button").count).to eq(200)
      
      first(".delete-button").click
      
      expect(Contact.count).to eq(199)
    end
  end
end
