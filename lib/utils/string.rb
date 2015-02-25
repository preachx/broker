class String
  def is_positive_integer?
    /\A\d+\z/.match(self)
  end
end