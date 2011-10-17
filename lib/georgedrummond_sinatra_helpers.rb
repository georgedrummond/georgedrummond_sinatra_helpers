require "georgedrummond_sinatra_helpers/version"

module GeorgeDrummond
  module Sinatra
    module Helpers
      # Creates html tags for stylesheets from the arguements provided. Dont include the <tt>.css</tt> extension as this
      # will be automatically appended. You can specify one or multiple css files at once. Place your css files in
      # the <tt>public/css</tt> folder of your app.
      #
      # ==== Examples
      #
      # With only one CSS file
      #
      #    stylesheet_link_tag :app
      #    # => <link href="/css/app.css" type="text/css" />
      #
      # With an array of CSS files we want to show
      #
      #    stylesheet_link_tag :app, :header # =>
      #      <link href="/css/app.css" type="text/css" />
      #      <link href="/css/header.css" type="text/css" />
      def stylesheet_link_tag(*sources)
        html = []
        sources.each do |stylesheet|
          path = "/css/#{stylesheet}.css"
          html << "<link href=\"#{ url(path) }\" type=\"text/css\" />"
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
