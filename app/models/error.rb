module Error

  ### Used as a warning when incorrect data is being generating
  class InvalidBehaviour < StandardError
  end

  class Unauthorized < StandardError
  end

end
