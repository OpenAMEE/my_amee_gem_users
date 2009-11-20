module MyAmeeHelper

  def logout_url
    "#{$my_amee_config['url']}/logout?next=#{@controller.current_url}"
  end

  def login_url
    "#{$my_amee_config['url']}/login?next=#{@controller.current_url}"
  end

end