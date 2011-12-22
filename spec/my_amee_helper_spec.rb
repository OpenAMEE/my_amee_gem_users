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
  def controller
    @controller
  end
end

describe TestClass do
  
  before :all do 
    @t = TestClass.new
    @t.controller = flexmock 'controller', {:current_url => '/foo/bar'}
  end
  
  it 'should be able to generate a login url' do
    @t.login_url.should eql "https://my.amee.com/login?next=%2Ffoo%2Fbar"
  end
  
  it 'should be able to generate a logout url' do
    @t.logout_url.should eql "https://my.amee.com/logout?next=%2Ffoo%2Fbar"
  end

  it 'should be able to generate a preferences url' do
    @t.preferences_url.should eql "https://my.amee.com/preferences"
  end

end

describe TestClass, 'with URLs with strange symbols' do
  
  it 'should be able to generate a valid login url' do
    @t = TestClass.new
    @t.controller = flexmock 'controller', {:current_url => 'http://example.com/foo & bar/hello!/what?/well, there you go.'}
    @t.login_url.should eql "https://my.amee.com/login?next=http%3A%2F%2Fexample.com%2Ffoo+%26+bar%2Fhello%21%2Fwhat%3F%2Fwell%2C+there+you+go."
  end

end
