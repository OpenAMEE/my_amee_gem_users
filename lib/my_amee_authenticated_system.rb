require 'my_amee/users'

module MyAmeeAuthenticatedSystem
  # Based on AuthenticatedSystem from the restful_authentication plugin

  protected
    # Returns true or false if the user is logged in.
    # Preloads @current_user with the user model if they're logged in.
    def logged_in?
      !!current_user
    end

    # Accesses the current user from the session.
    # Future calls avoid the database because nil is not equal to false.
    def current_user
      @current_user ||= login_from_session unless @current_user == false
    end

    # Store the given user login in the session.
    def current_user=(new_user)
      session[:user_login] = new_user ? new_user.login : nil
      @current_user = new_user || false
    end

    # Check if the user is authorized
    #
    # Override this method in your controllers if you want to restrict access
    # to only a few actions or if you want to check if the user
    # has the correct rights.
    #
    # Example:
    #
    #  # only allow nonbobs
    #  def authorized?
    #    current_user.login != "bob"
    #  end
    #
    def authorized?(action=nil, resource=nil, *args)
      logged_in?
    end

    # Filter method to enforce a login requirement.
    #
    # To require logins for all actions, use this in your controllers:
    #
    #   before_filter :login_required
    #
    # To require logins for specific actions, use this in your controllers:
    #
    #   before_filter :login_required, :only => [ :edit, :update ]
    #
    # To skip this in a subclassed controller:
    #
    #   skip_before_filter :login_required
    #
    def login_required
      authorized? || access_denied
    end

    def admin_login_required
      login_required
      if current_user
        render_http_code 401 unless current_user.is_admin?
      end
    end

    def logout_url
      "#{$my_amee_config['url']}/logout?next=#{current_url}"
    end

    def login_url
      "#{$my_amee_config['url']}/login?next=#{current_url}"
    end

    # Redirect as appropriate when an access request fails.
    #
    # The default action is to redirect to the login screen.
    #
    # Override this method in your controllers if you want to have special
    # behavior in case the user is not authorized
    # to access the requested action.  For example, a popup window might
    # simply close itself.
    def access_denied
      respond_to do |format|
        format.html do
          redirect_to login_url
        end
        # format.any doesn't work in rails version < http://dev.rubyonrails.org/changeset/8987
        # you may want to change format.any to e.g. format.any(:js, :xml)
        format.any do
          request_http_basic_authentication 'Web Password'
        end
      end
    end

    # Inclusion hook to make #current_user and #logged_in?
    # available as ActionView helper methods.
    def self.included(base)
      base.send :helper_method, :current_user, :logged_in?, :authorized? if base.respond_to? :helper_method
    end

    #
    # Login
    #

    # Called from #current_user.  First attempt to login by the user login stored in the session.
    def login_from_session
      self.current_user = MyAmee::User.find(session[:user_login]) if session[:user_login]
    end

end
