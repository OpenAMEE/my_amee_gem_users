module MyAmeeHelper

  def logout_url
    "#{MyAmee::Config.get['url']}/logout?next=#{controller.current_url}"
  end

  def login_url
    "#{MyAmee::Config.get['url']}/login?next=#{controller.current_url}"
  end

  def preferences_url
    "#{MyAmee::Config.get['url']}/preferences"
  end

end