Gem::Specification.new do |s|
  s.name = "my_amee_users"
  s.version = "1.4.0"
  s.date = "2011-08-25"
  s.summary = "Rails plugin to allow user integration with my.amee.com"
  s.email = "james@amee.com"
  s.homepage = "https://my.amee.com"
  s.has_rdoc = true
  s.authors = ["James Smith"]
  s.files = ["README", "COPYING"] 
  s.files += ['lib/my_amee/users.rb']
  s.files += ['lib/my_amee_helper.rb', 'lib/my_amee_authenticated_system.rb']
  s.files += ['init.rb', 'rails/init.rb', 'lib/my_amee_users.rb']
  s.add_dependency("my_amee_core", "~> 1.1")
  s.add_dependency("json")
  s.add_dependency("curb", "~> 0.7")
  s.add_dependency("activesupport")
end
