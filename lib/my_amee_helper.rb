module MyAmeeHelper

  def signup_url
    "#{MyAmee::Config.get['url']}/signup?next=#{CGI.escape(controller.current_url)}"
  end

  def logout_url
    "#{MyAmee::Config.get['url']}/logout?next=#{CGI.escape(controller.current_url)}"
  end

  def login_url
    "#{MyAmee::Config.get['url']}/login?next=#{CGI.escape(controller.current_url)}"
  end

  def preferences_url
    "#{MyAmee::Config.get['url']}/preferences"
  end

end