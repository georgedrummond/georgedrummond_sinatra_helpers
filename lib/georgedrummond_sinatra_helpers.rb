require "georgedrummond_sinatra_helpers/version"
require "digest/md5"
require "uri"

module GeorgeDrummond
  module Sinatra
    module Helpers
      # Creates the html for a mail_to link being given an email address and an optional text argument
      #
      # ==== Examples
      #
      # With only an email address provided:
      #
      #   mail_to("georgedrummond@gmail.com")
      #     # => <a href="mailto:georgedrummond@gmail.com" class="mailto">georgedrummond@gmail.com</a>
      #
      # With an optional text field provided:
      #
      #   mail_to("georgedrummond@gmail.com", "George Drummond")
      #     # => <a href="mailto:georgedrummond@gmail.com" class="mailto">George Drummond</a>
      #
      # With an options hash:
      #
      #   mail_to("georgedrummond@gmail.com", "George Drummond", :class => :email, :title => "How do you do")
      #     # => <a href="mailto:georgedrummond@gmail.com" class="email" title="How do you do">George Drummond</a>
      #
      def mail_to(email, text=email, opts={})
        options = {:class => :mailto}.merge(opts)
        link_to text, "mailto:#{email}", options, false
      end
      
      # Creates the gravatar (www.gravatar.com) html from the email address and arguments provided.
      # If no size is specified then it defaults to 50x50px
      #
      # ==== Examples
      #
      # With no size specified:
      #
      #   gravatar_image("georgedrummond@gmail.com")
      #     # => <img src="http://www.gravatar.com/avatar/d278a12b969a495ab16fdd942e748fe5?s=50" class="gravatar" />
      #
      # With a size specified:
      #
      #   gravatar_image("georgedrummond@gmail.com", 150)
      #     # => <img src="http://www.gravatar.com/avatar/d278a12b969a495ab16fdd942e748fe5?s=150" class="gravatar" />
      #
      # With options:
      #
      #   gravatar_image("georgedrummond@gmail.com", 150, :class => :icon)
      #     # =>  <img src="http://www.gravatar.com/avatar/d278a12b969a495ab16fdd942e748fe5?s=150" class="icon" />
      #
      def gravatar_image(email, size=50, opts={})
        hash = Digest::MD5.hexdigest(email)
        url = "http://www.gravatar.com/avatar/#{hash}?s=#{size}"
        image_tag url, {:class => :gravatar}.merge(opts)
      end
      
      # Creates html tags for stylesheets from the arguements provided. Dont include the <tt>.css</tt> extension as this
      # will be automatically appended. You can specify one or multiple css files at once. Place your css files in
      # the <tt>public/css</tt> folder of your app. URLs will link to external files
      #
      # ==== Examples
      #
      # With only one CSS file:
      # 
      #   stylesheet_link_tag :app
      #    # => <link href="/css/app.css" type="text/css" rel="stylesheet" />
      #
      # With an array of CSS files we want to show:
      #
      #    stylesheet_link_tag :app, :header # =>
      #      <link href="/css/app.css" type="text/css" rel="stylesheet" />
      #      <link href="/css/header.css" type="text/css" rel="stylesheet" />
      #
      # With an external stylesheet:
      #
      #   stylesheet_link_tag :app, "http://accountsapp.com/styles/common.css"
      #     <link href="/css/app.css" type="text/css" rel="stylesheet" />
      #     <link href="http://accountsapp.com/styles/common.css" type="text/css" rel="stylesheet" />
      #
      def stylesheet_link_tag(*sources)
        html = []
        sources.each do |stylesheet|
          if is_uri?(stylesheet)
            path = stylesheet
          else
            path = url("/css/#{stylesheet}.css")
          end
          html << "<link href=\"#{path}\" type=\"text/css\" rel=\"stylesheet\" />"
        end
        return html.join("\n")
      end
      
      # Creates html tags for javascript includes from the arguments provided. Dont include the <tt>.js</tt> extension as this
      # will be automatically appended. You can specify one or multiple javascript files at once. Place your javascript files in
      # the <tt>public/js</tt> folder of your app. URLs will link to external files
      #
      # ==== Examples
      #
      # With only one javascript file
      #
      #   javascript_include_tag :app
      #     # => <script type="text/javascript" src="/js/app.js"></script>
      #
      # With an array of javascript files we want to show:
      #
      #   javascript_include_tag :jquery, :app # =>
      #     <script type="text/javascript" src="/js/jquery.js"></script>
      #     <script type="text/javascript" src="/js/app.js"></script>
      #
      # With an external stylesheet:
      #
      #   javascript_include_tag :jquery, "http://accountsapp.com/js/app.js"
      #     <script type="text/javascript" src="/js/jquery.js"></script>
      #     <script type="text/javascript" src="http://accountsapp.com/js/app.js"></script>
      #    
      def javascript_include_tag(*sources)
        html = []
        sources.each do |javascript|
          if is_uri?(javascript)
            path = javascript
          else
            path = url("/js/#{javascript}.js")
          end
          html << "<script type=\"text/javascript\" src=\"#{path}\"></script>"
        end
        return html.join("\n")
      end
      
      # Creates a html image tag given a file name. File should be located in <tt>public/images</tt>.
      #
      # ==== Examples
      #
      # With a local image:
      #
      #   image_tag "home.png"
      #     # => <img src="/images/home.png" />
      #
      # With options:
      #
      #   image_tag "home.png", :title => "home", :class => :icon
      #     # => <img src="/images/home.png" title="home" class="icon" />
      #
      # With a remote image:
      #
      #   image_tag "http://accountsapp.com/logo.png", :title => "Online Accounting Software"
      #     # => <img src="http://accountsapp.com/logo.png" title="Online Accounting Software" />
      #
      def image_tag(image, opts={})
        if is_uri?(image)
          path = image
        else
          path = url("/images/#{image}")
        end
        return "<img src=\"#{path}\"#{parse_options(opts)} />"
      end
    
      # Creates a html link tag given a page <tt>title</tt> and resource <tt>path</tt>.
      #
      # ==== Examples
      #
      # With an internal link
      #
      #   link_to "Home", "/home"
      #     # => <a href="/home">Home</a>
      #
      # With options:
      #
      #   link_to "Home", "/home", :title => "Home Page"
      #     # => <a href="/home" title="Home Page">Home</a>
      #
      # For an external URL:
      #
      #   link_to "AccountsApp", "http://accountsapp.com", :title => "Online Invoicing Software"
      #     # => <a href="http://accountsapp.com" title="Online Invoicing Software">AccountsApp</a>
      #
      def link_to(title, path, opts={}, base=true)
        unless is_uri?(path) || base == false
          path = url(path)
        end
        
        return "<a href=\"#{path}\"#{parse_options(opts)}>#{title}</a>"
      end
      
      private
        def parse_options(opts)
          unless opts.empty?
            html = [""]
            opts.each do |key, value|
              final_value = value.is_a?(Array) ? value.join(" ") : value
              html << "#{key}=\"#{final_value}\""
              #return attrs.join
            end
            return html.join(" ")
          end
        end
        
        def is_uri?(path)
          URI.parse(path).class == URI::HTTP
        end    
    end
  end
end
