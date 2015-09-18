require 'phone'

class FileUploader
  attr_reader :fp
  
  def initialize(file_params)
    @fp = file_params
  end
  
  def to_tsv
    Phoner::Phone.default_country_code = '1'
    Parser.new(fp).set_tsv
  end
end
