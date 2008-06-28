require 'FileUtils'

module GitBlog
  class Post
    
    class <<self
      # Returns a new Post object, based on a path to a post.
      def open path
        Post.new :slug => File.basename(path).split('.').first
      end
      
      # Returns a new Post object, based on a git commit object
      # TODO: Implement this!
      def find commit
        raise ArgumentError, 'must pass a Grit::Commit object' unless commit.is_a?(Grit::Commit)
        commit
      end
    end
    
    attr_accessor :slug, :title
    
    def initialize opts = {}, &block
      @slug = opts[:slug]
      @title = opts[:title]
      
      yield if block_given?
    end
    
    # TODO: Make #title and #slug use their opposites in the unless... blocks, without causing infinite recursion
    def title
      @title ||= Post.title slug unless @slug.nil?
      @title
    end
    
    def slug
      @slug ||= title.slugize unless @title.nil?
      @slug
    end
    
  end
end


# -- + --- Specs --- + -- #

describe GitBlog::Post do
  
  describe '(class)' do
    it "should open a post from a path" do
      @post = GitBlog::Post.open 'posts/a_test_post.markdown'
      @post.should be_an_instance_of(GitBlog::Post)
      @post.slug.should == 'a_test_post'
    end
  end
  
  describe '(instance)' do
    before :each do
      @post = GitBlog::Post.new :title => 'A Test Post!'
    end
  
    it "should have a title" do
      @post.title.should == 'A Test Post!'
    end
  
    it "should have a slug" do
      @post.slug.should == 'a_test_post'
    end
  end
  
end