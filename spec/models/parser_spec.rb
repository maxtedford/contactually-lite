require 'rails_helper'

RSpec.describe Parser, type: :model do
  context "file parsing" do

    let(:upload_file) {
      extend ActionDispatch::TestProcess
      fixture_file_upload("data.tsv", "text/tab-separated-values")
    }
    
    it "can parse a file" do
      parser = Parser.new(upload_file)
      
      expect(parser.set_tsv).to be_a(CSV::Table)
    end
    
    it "can return its rows" do
      tsv = Parser.new(upload_file).set_tsv
      
      expect(tsv.first).to be_a(CSV::Row)
      expect(tsv.length).to eq(200)
    end
  end
end
