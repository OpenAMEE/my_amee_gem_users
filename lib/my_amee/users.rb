require 'my_amee/config'

module MyAmee
  class User

    def initialize(attributes)
      @attributes = attributes.symbolize_keys
    end

    def method_missing(symbol, *args)
      return @attributes[symbol] if @attributes[symbol]
      super
    end

    def is_admin?
      roles.include? 'admin'
    end

    def self.find(login)
      user = nil
      # Load appstore config from YAML
      config = Config.appstore_config
      if config
        # Generate user URL
        url = URI.parse("#{config['url']}/users/#{login}.json")
        http = Net::HTTP.new(url.host, url.port)
        http.start do
          get = Net::HTTP::Get.new(url.path)
          response = http.request(get)
          if response.code == '200'
            user = User.new(JSON.parse(response.body))
          end
        end
      end
      user
    end
    
  end
end
