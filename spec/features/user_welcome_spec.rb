require "rails_helper"

describe "the user", type: :feature do
  context "when visiting the root page" do
    
    it "will see a welcome message" do
      visit root_path
      
      expect(page).to have_content("Welcome to Contactually-Lite!")
    end
  end
end
