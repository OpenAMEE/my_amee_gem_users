module MyAmee

  module CurrentPath
    def self.included(base)
      base.class_eval do
        before_filter :set_current_path
      end
    end

    def set_current_path
      path_match = request.host.match('^(.*?)\..*$')
      Thread.current[:current_path] = path_match ? path_match[1] : nil
      # Reestablish database connection now we have a path set
      ActiveRecord::Base.establish_connection
    end

    def self.get
      Thread.current[:current_path]
    end

  end

end