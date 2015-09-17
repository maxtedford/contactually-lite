class Normalizer
  attr_reader :pn
  
  def initialize(phone_number)
    @pn = phone_number
  end

  def normalize
    pn.gsub(/[^0-9A-Za-z]/, '')
  end

  def internationalize
    normalized = normalize
    if (normalized.length > 10 && !normalized.include?("x")) || (normalized.length > 10 && normalized.first == "1")
      "+" << pn
    elsif normalized.first == "0"
      "+1" << pn
    else
      pn
    end
  end
end
