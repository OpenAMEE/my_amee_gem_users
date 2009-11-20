require 'my_amee/config'

module ActionView
  module Helpers
    module AssetTagHelper
      def stylesheet_path_with_my_amee(source)
        # Fetch config
        config = MyAmee::Config.application_config(:theme)
        # If theme is set, get stylesheet url
        if config
          extension = source =~ /^.*\.css/ ? "" : ".css"
          return "#{config['url']}/stylesheets/#{source}#{extension}"
        else
          return stylesheet_path_without_my_amee(source)
        end
      end
      alias_method_chain :stylesheet_path, :my_amee
      alias_method :path_to_stylesheet, :stylesheet_path_with_my_amee
    end
  end
end