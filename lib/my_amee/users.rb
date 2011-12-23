require 'my_amee/config'
require 'typhoeus'

module MyAmee
  class User

    def initialize(attributes)
      @attributes = attributes.inject({}) do |options, (key, value)|
        options[(key.to_sym rescue key) || key] = value
        options
      end
    end

    def has_key?(symbol)
      @attributes[symbol] ? true : false
    end

    def method_missing(symbol, *args)
      return @attributes[symbol] if @attributes[symbol]
      super
    end

    def is_admin?
      roles.include? 'admin'
    end

    def is_audit?
      roles.include? 'audit'
    end

    def is_oem?
      !is_audit?
    end

    def self.find(login)
      user = nil
      # Load appstore config from YAML
      config = MyAmee::Config.get
      if config
        # Generate user URL
        url = "#{config['url']}/users/#{login}.json"
        r = Typhoeus::Request.get(url)
        if r.response_code == 200
          user = User.new(JSON.parse(r.body_str))
        end
      end
      user
    end
    
  end
end
