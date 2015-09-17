class Parser
  attr_reader :file
  
  def initialize(file)
    @file = file
  end
  
  def set_tsv
    file_path = file.tempfile.to_path.to_s
    text = File.read(file_path, {encoding: "UTF-8"})
    CSV.parse(text, headers: true, header_converters: :symbol, col_sep: "\t")
  end
end
