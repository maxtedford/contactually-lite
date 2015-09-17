require 'rails_helper'

RSpec.describe Normalizer, type: :model do
  context "phone number normalization" do
    
    it "can normalize a phone number" do
      normalizer = Normalizer.new("081-799-3139 x248")
      
      expect(normalizer.normalize).to eq("0817993139x248")
    end
    
    it "can internationalize a phone number" do
      normalizer = Normalizer.new("081-799-3139 x248")
      
      expect(normalizer.internationalize).to eq("+1081-799-3139 x248")
    end
  end
end
