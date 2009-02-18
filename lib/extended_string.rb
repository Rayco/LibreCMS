class String
  def to_url
    self.gsub!(/%+/i, '%25')
    self.gsub!(/_+/i, '%5F')
    self.gsub!(/\/+/i, '%2F')
    self.gsub!(/\s+/i, '_')
    self
  end
  
  def from_url
    self.gsub!(/_+/i, "\s")
    self.gsub!(/(%5F)+/i, '_')
    self.gsub!(/(%2F)+/i, '/')
    self.gsub!(/(%25)+/i, '%')
    self
  end
end