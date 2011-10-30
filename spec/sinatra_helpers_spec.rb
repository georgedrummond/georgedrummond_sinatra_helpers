require File.join(File.dirname(__FILE__), '..', 'lib', 'georgedrummond_sinatra_helpers.rb')

include GeorgeDrummond::Sinatra::Helpers

def url(url)
  return File.join("/path", url)
end

describe GeorgeDrummond::Sinatra::Helpers do
  
  describe "mail_to" do
    it "with only an email address provided" do
      mail_to("georgedrummond@gmail.com").should == "<a href=\"mailto:georgedrummond@gmail.com\" class=\"mailto\">georgedrummond@gmail.com</a>"
    end
    
    it "with an optional text field provided" do
      mail_to("georgedrummond@gmail.com", "George Drummond").should == "<a href=\"mailto:georgedrummond@gmail.com\" class=\"mailto\">George Drummond</a>"
    end
    
    it "wth an options hash" do
      mail_to("georgedrummond@gmail.com", "George Drummond", :class => :email, :title => "How do you do").should == "<a href=\"mailto:georgedrummond@gmail.com\" class=\"email\" title=\"How do you do\">George Drummond</a>"
    end
  end
  
  describe "gravatar_image" do
    it "with no size specified" do
      gravatar_image("georgedrummond@gmail.com").should == "<img src=\"http://www.gravatar.com/avatar/d278a12b969a495ab16fdd942e748fe5?s=50\" class=\"gravatar\" />"
    end
    
    it "with a size specified" do
      gravatar_image("georgedrummond@gmail.com", 150).should == "<img src=\"http://www.gravatar.com/avatar/d278a12b969a495ab16fdd942e748fe5?s=150\" class=\"gravatar\" />"
    end
    
    it "with options" do
      gravatar_image("georgedrummond@gmail.com", 150, :class => :icon).should == "<img src=\"http://www.gravatar.com/avatar/d278a12b969a495ab16fdd942e748fe5?s=150\" class=\"icon\" />"
    end
  end
  
  
  describe "link_to" do
    it "with an internal link" do
      link_to("Home", "/home").should == '<a href="/path/home">Home</a>'
    end
    
    it "with options" do
      link_to("Home", "/home", :title => "Home Page").should == '<a href="/path/home" title="Home Page">Home</a>'
    end
    
    it "for an external URL" do
      link_to("AccountsApp", "http://accountsapp.com", :title => "Online Invoicing Software").should == '<a href="http://accountsapp.com" title="Online Invoicing Software">AccountsApp</a>'
    end
  end

  describe "image_tag" do
    it "with a local image" do
      image_tag("home.png").should == '<img src="/path/images/home.png" />'
    end
    
    it "with options" do
      image_tag("home.png", :title => "home", :class => :icon).should == '<img src="/path/images/home.png" title="home" class="icon" />'
    end
    
    it "with an external image" do
      image_tag("http://accountsapp.com/logo.png", :title => "Online Accounting Software").should == '<img src="http://accountsapp.com/logo.png" title="Online Accounting Software" />'
    end
  end
  
  describe "stylesheet_link_tag" do
    it "with a single stylesheet" do
      stylesheet_link_tag(:app).should == "<link href=\"/path/css/app.css\" type=\"text/css\" rel=\"stylesheet\" />"
    end
    
    it "with an array of stylesheets" do
      stylesheet_link_tag(:app, :header).should == "<link href=\"/path/css/app.css\" type=\"text/css\" rel=\"stylesheet\" />\n<link href=\"/path/css/header.css\" type=\"text/css\" rel=\"stylesheet\" />"
    end
    
    it "with an external stylesheet" do
      stylesheet_link_tag(:app, "http://accountsapp.com/styles/common.css").should == "<link href=\"/path/css/app.css\" type=\"text/css\" rel=\"stylesheet\" />\n<link href=\"http://accountsapp.com/styles/common.css\" type=\"text/css\" rel=\"stylesheet\" />"
    end
  end
  
  describe "javascript_include_tag" do
    it "with a single js file" do
      javascript_include_tag(:app).should == "<script type=\"text/javascript\" src=\"/path/js/app.js\"></script>"
    end
    
    it "with an array of js files" do
      javascript_include_tag(:jquery, :app).should == "<script type=\"text/javascript\" src=\"/path/js/jquery.js\"></script>\n<script type=\"text/javascript\" src=\"/path/js/app.js\"></script>"
    end
    it "with an external js file" do
      javascript_include_tag(:jquery, "http://accountsapp.com/js/app.js").should == "<script type=\"text/javascript\" src=\"/path/js/jquery.js\"></script>\n<script type=\"text/javascript\" src=\"http://accountsapp.com/js/app.js\"></script>"
    end
  end
end
