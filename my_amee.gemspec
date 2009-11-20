Gem::Specification.new do |s|
  s.name = "my_amee"
  s.version = "1.0.0"
  s.date = "2009-11-19"
  s.summary = "Rails plugin to help integrate apps into my.amee.com"
  s.email = "james@amee.cc"
  s.homepage = "http://my.amee.com"
  s.has_rdoc = true
  s.authors = ["James Smith"]
  s.files = ["README", "COPYING"] 
  s.files += ['lib/my_amee.rb', 'lib/my_amee/amee.rb', 'lib/my_amee/config.rb', 'lib/my_amee/stylesheets.rb', 'lib/my_amee/images.rb', 'lib/my_amee/users.rb']
  s.files += ['lib/my_amee_helper.rb', 'lib/my_amee_authenticated_system.rb']
  s.files += ['init.rb', 'rails/init.rb', 'my_amee.example.yml']
  s.files += ['bin/my_amee_extract_theme']
  s.executables = ['my_amee_extract_theme']
  s.add_dependency("json")
  s.add_dependency("amee", ">=2.0.28")
end
