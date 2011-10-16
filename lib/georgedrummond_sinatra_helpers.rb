require "georgedrummond_sinatra_helpers/version"

module GeorgeDrummond
  module Sinatra
    module Helpers
    
      def stylesheet_link_tag(*sources)
        html = []
        sources.each do |stylesheet|
          path = "/css/#{stylesheet}.css"
          html << "<link href=\"#{ url(path) }\" type=\"text/css\" />"
        end
        return html.join("\n")
      end
    
      def javascript_include_tag(*sources)
        html = []
        sources.each do |javascript|
          path = "/js/#{javascript}.js"
          html << "<script type=\"text/javascript\" src=\"#{ url(path) }\"></script>"
        end
        return html.join("\n")
      end
    
      def image_tag(image)
        path = "/images/#{image}"
        return "<img src=\"#{url(path)}\" />\n"
      end
    
      def link_to(title, path)
        return "<a href=\"#{url(path)}\">#{title}</a>"
      end
    
    end
  end
end
