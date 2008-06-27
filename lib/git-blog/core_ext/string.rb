class String
  UnacceptableCharacters = /[^a-z0-9]/
  SafeCharacter = '_'
  include File::Extension
  
  def slugize
    string = self
    string = string.downcase
    string = string.strip
    string = string.gsub /#{UnacceptableCharacters}/, SafeCharacter
    string = string.gsub /_+/, SafeCharacter
    string = string.gsub /(^#{UnacceptableCharacters}|#{UnacceptableCharacters}$)/, ''
  end
  
  def /(o)
    File.join(self, o.to_s)
  end
end