# Courtesy of Mikael Høilund, released under cc-something-somthinge-somethingthatisn'tderivateworks
class Hash
  
  def -(other)
    ret = self.dup
    ret.delete_if { |k, v| other.has_key? k }
    ret # don't reember what delete_if returns
    # Elliott is lazy
  end
  
end