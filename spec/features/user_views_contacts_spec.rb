require "rails_helper"

describe "the user", type: :feature do
  context "when viewing his/her contacts" do
    
    before(:each) {
      DatabaseCleaner.start
      DatabaseCleaner.clean
      visit root_path
      attach_file("contacts_file", Rails.root.join("spec/fixtures/data.tsv"))
      click_button("upload")
    }
    
    it "can see all his/her contacts" do
      expect(page).to have_content("Gerhard")
      expect(page).to have_content("Kautzer")
      expect(page).to have_content("Hodkiewicz-Lynch")
      expect(page).to have_content("gerhardkautzer@cronabayer.com")
      expect(page).to have_content("+1 (207) 643-1816")
      expect(page.all(:css, 'tr').length).to eq(201)
      expect(page.all(:css, 'td.contact-email').length).to eq(200)
    end

    it "can see a delete button for each contact" do
      expect(page).to have_button("Delete")
      expect(page.all(:css, 'button.delete-button').length).to eq(200)
    end

    it "can see a filter button for international phone numbers" do
      expect(page).to have_button("International Numbers")
      expect(page.all(:css, 'button#international-filter-button').length).to eq(1) 
    end
    
    it "can see a filter button for phone numbers with extensions" do
      expect(page).to have_button("Contacts with Extensions")
      expect(page.all(:css, 'button#extension-filter-button').length).to eq(1)
    end

    it "can see a filter button for emails ending in .com" do
      expect(page).to have_button("Contacts with .com Email Address")
      expect(page.all(:css, 'button#dot-com-filter-button').length).to eq(1)
    end

    it "can see a button to sort contacts by email" do
      expect(page).to have_button("Sort by Email Address")
      expect(page.all(:css, 'button#sort-by-email-address').length).to eq(1)
    end

    it "can see a filter button for all contacts" do
      expect(page).to have_button("All")
      expect(page.all(:css, 'button#all').length).to eq(1)
    end
  end
end
