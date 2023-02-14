class Isbn::InvalidLengthException < StandardError
  def message
    "Please, set a 12 or a 13 length number"
  end
end
