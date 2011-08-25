require File.dirname(__FILE__) + '/spec_helper.rb'
require 'my_amee_helper'

$my_amee_config = {
  'url' => 'https://my.amee.com'
}

class TestClass
  include MyAmeeHelper
  def controller=(val)
    @controller = val
  end
end

describe TestClass do
  
  before :all do 
    @t = TestClass.new
    @t.controller = flexmock 'controller', {:current_url => '/foo/bar'}
  end
  
  it 'should be able to generate a login url' do
    @t.login_url.should eql "https://my.amee.com/login?next=/foo/bar"
  end
  
  it 'should be able to generate a logout url' do
    @t.logout_url.should eql "https://my.amee.com/logout?next=/foo/bar"
  end

  it 'should be able to generate a preferences url' do
    @t.preferences_url.should eql "https://my.amee.com/preferences"
  end

end