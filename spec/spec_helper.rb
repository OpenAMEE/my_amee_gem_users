require 'rubygems'
require 'spec'

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'my_amee'

Spec::Runner.configure do |config|
  config.mock_with :flexmock
end

class Rails
  def self.root
    File.dirname(__FILE__)
  end
  def self.env
    'test'
  end
end