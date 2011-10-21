require "georgedrummond_sinatra_helpers/version"
require "digest/md5"

module GeorgeDrummond
  module Sinatra
    module Helpers
      # Creates the html for a mail_to link being given an email address and an optional text argument
      #
      # ==== Examples
      #
      # With only an email address provided
      #
      #   mail_to("georgedrummond@gmail.com")
      #     # => <a href="mailto:georgedrummond@gmail.com" class="mailto">georgedrummond@gmail.com</a>
      #
      # With an optional text field provided
      #
      #   mail_to("georgedrummond@gmail.com", "George Drummond")
      #     # => <a href="mailto:georgedrummond@gmail.com" class="mailto">George Drummond</a>
      def mail_to(email, text=email)
        "<a href=\"mailto:\#{email}\" class=\"mailto\">#{text}</a>"
      end
      
      # Creates the gravatar (www.gravatar.com) html from the email address and arguments provided.
      # If no size is specified then it defaults to 50x50px
      #
      # ==== Examples
      #
      # With no size specified
      #
      #   gravatar_image("georgedrummond@gmail.com")
      #     # => <img src="http://www.gravatar.com/avatar/d278a12b969a495ab16fdd942e748fe5?s=50" class="gravatar" />
      #
      # With a size specified
      #
      #   gravatar_image("georgedrummond@gmail.com", 150)
      #     # => <img src="http://www.gravatar.com/avatar/d278a12b969a495ab16fdd942e748fe5?s=150" class="gravatar" />
      def gravatar_image(email, size=50)
        hash = Digest::MD5.hexdigest(email)
        "<img src=\"http://www.gravatar.com/avatar/#{hash}?s=#{size}\" class=\"gravatar\" />"
      end
      
      # Creates html tags for stylesheets from the arguements provided. Dont include the <tt>.css</tt> extension as this
      # will be automatically appended. You can specify one or multiple css files at once. Place your css files in
      # the <tt>public/css</tt> folder of your app.
      #
      # ==== Examples
      #
      # With only one CSS file
      # 
      #   stylesheet_link_tag :app
      #    # => <link href="/css/app.css" type="text/css" rel="stylesheet" />
      #
      # With an array of CSS files we want to show
      #
      #    stylesheet_link_tag :app, :header # =>
      #      <link href="/css/app.css" type="text/css" rel="stylesheet" />
      #      <link href="/css/header.css" type="text/css" rel="stylesheet" />
      def stylesheet_link_tag(*sources)
        html = []
        sources.each do |stylesheet|
          path = "/css/#{stylesheet}.css"
          html << "<link href=\"#{ url(path) }\" type=\"text/css\" rel=\"stylesheet\" />"
        end
        return html.join("\n")
      end
      
      # Creates html tags for javascript includes from the arguments provided. Dont include the <tt>.js</tt> extension as this
      # will be automatically appended. You can specify one or multiple javascript files at once. Place your javascript files in
      # the <tt>public/js</tt> folder of your app.
      #
      # ==== Examples
      #
      # With only one javascript file
      #
      #    javascript_include_tag :app
      #    # => <script type="text/javascript" src="/js/app.js"></script>
      #
      # With an array of javascript files we want to show
      #
      #    javascript_include_tag :jquery, :app # =>
      #      <script type="text/javascript" src="/js/jquery.js"></script>
      #      <script type="text/javascript" src="/js/app.js"></script>
      def javascript_include_tag(*sources)
        html = []
        sources.each do |javascript|
          path = "/js/#{javascript}.js"
          html << "<script type=\"text/javascript\" src=\"#{ url(path) }\"></script>"
        end
        return html.join("\n")
      end
      
      # Creates a html image tag given a file name. File should be located in <tt>public/images</tt>. Will not work with external
      # files for now however I may add this at a later date if it is needed.
      #
      # ==== Examples
      #
      #    image_tag "home.png"
      #    # => <img src="/images/home.png" />
      def image_tag(image)
        path = "/images/#{image}"
        return "<img src=\"#{url(path)}\" />\n"
      end
    
      # Creates a html link tag given a page <tt>title</tt> and resource <tt>path</tt>. Works similar to the Rails link_to method
      # however does not accept any other options.
      #
      # ==== Examples
      #
      #    link_to "Home", "/"
      #    # => <a href="/">Home</a>
      def link_to(title, path)
        return "<a href=\"#{url(path)}\">#{title}</a>"
      end
    
    end
  end
end
