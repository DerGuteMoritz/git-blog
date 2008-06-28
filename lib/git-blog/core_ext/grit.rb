module Grit
  class Tree
    
    def to_hash
      contents.inject({}) {|h, o| h[o.name] = o ; h }
    end
    
  end
  
  class Commit
    
    def new_tree
      t = self.tree.to_hash
      parents.each do |parent|
        t = t - parent.tree.to_hash
      end
      self.tree.contents.reject {|o| !t.values.include?(o) }
    end
    
  end
end

describe Grit::Tree do
  
  # TODO: Require Mocha, so I can mock a repo and actually spec this
  it "should convert to a name/object hash" do
    
  end
  
end