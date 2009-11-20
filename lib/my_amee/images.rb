require 'my_amee/config'

module ActionView
  module Helpers
    module AssetTagHelper
      def image_path_with_my_amee(source)
        # Fetch config
        config = MyAmee::Config.application_config(:theme)
        # If theme is set, get stylesheet url
        if config
          return "#{config['url']}/images/#{source}"
        else
          return image_path_without_my_amee(source)
        end
      end
      alias_method_chain :image_path, :my_amee
      alias_method :path_to_image, :image_path_with_my_amee
    end
  end
end
