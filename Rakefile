require 'rubygems'
($:.unshift(File.join( File.expand_path(File.dirname(__FILE__)), 'lib' ))).uniq!; require 'git-blog'
Dir['task/**/*.task'].each {|t| load t}
require 'fileutils'; include FileUtils

Echoe.taskify do
  Echoe.new('git-blog', GitBlog::VERSION) do |g|; g.project = 'git-blog'
    g.author = ['elliottcable']
    g.email = ['git-blog@elliottcable.com']
    g.summary = 'Minimalistic, git based blogware'
    g.url = 'http://find.elliottcable.name/git-blog'
    g.description = 'simple, uber-minimalistic blogging software, that uses git as a storage system for posts, and deploys to your webserver with git as well. no dynamic content, by design.'
    
    g.dependencies = ['mojombo-grit', 'haml']
    
    g.manifest_name = '.manifest'
    g.clean_pattern = ['pkg', 'meta', '*.gem']
    g.include_rakefile = true
    g.ignore_pattern = /^\.git/
    g.executable_pattern = ['bin/git-blog']
    g.has_rdoc = false
    
    g.install_message = " - Thanks for installing git-blog!\n" +
                        " - To get started, run the following in the local directory\n" +
                        " - in which you want your new blog to reside:\n" +
                        " -   git blog init"
  end
  
  desc 'Test packaged files to ensure they are all present'
  task :verify => :package do
    # An error message will be displayed if files are missing
    if system %(ruby -e "require 'rubygems'; require 'pkg/git-blog-#{GitBlog::VERSION}/lib/git-blog'")
      puts "\nThe library files are present"
    end
  end
  
  desc 'builds a gemspec as GitHub wants it'
  task :gemspec => [:package, :copy_gemspec, :clobber_package]
  
  task :copy_gemspec => [:package] do
    pkg = Dir['pkg/*'].select {|dir| File.directory? dir}.last
    mv File.join(pkg, pkg.gsub(/^pkg\//,'').gsub(/\-\d+$/,'.gemspec')), './'
  end
  
  # desc 'Run specs, clean tree, update manifest, run coverage, and install gem!'
  desc 'Clean tree, update manifest, and install gem!'
  task :magic => [:manifest, :install]
end