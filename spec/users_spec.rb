require File.dirname(__FILE__) + '/spec_helper.rb'
require 'my_amee/users'

describe MyAmee::User do
  
  it 'should access a user correctly' do
    user = MyAmee::User.find('james')
    user.should be_present
    user.organisation.should eql "AMEE"
    user.should be_is_admin
    user.should be_is_oem
    lambda {
      user.foo
    }.should raise_error
  end
  
end