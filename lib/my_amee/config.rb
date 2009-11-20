require "net/http"
require 'json'

module MyAmee
  class Config

    def self.appstore_config
      # Load appstore config from YAML
      my_amee_config = "#{RAILS_ROOT}/config/my_amee.yml"
      if File.exist?(my_amee_config)
        # Load config
        return YAML.load_file(my_amee_config)[RAILS_ENV]
      else
        info.logger "WARNING: My AMEE configuration file not found. Copy my_amee.example.yml to config/my_amee.yml and edit."
        return nil
      end
    end

    def self.application_config(section)
      path = ENV['MY_AMEE_PATH'] || MyAmee::CurrentPath.get
      if path
        # Load appstore config from YAML
        config = appstore_config
        if config && config['secret_key'] && config['url']
          # Generate configuration URL
          url = URI.parse("#{config['url']}/apps.json?app=#{config['secret_key']}&path=#{path}")
          # Get configuration from appstore
          return JSON.parse(Net::HTTP.get(url))[section.to_s]
        end
      end
      nil
    end
    
  end
end
