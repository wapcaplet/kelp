

Gem::Specification.new do |s|
  s.name = "kelp"
  s.version = "0.1.2"
  s.summary = "Cucumber helper methods"
  s.description = <<-EOS
    Kelp is a collection of helper methods for Cucumber to ease the process of
    writing step definitions.
  EOS
  s.authors = ["Eric Pierce"]
  s.email = "wapcaplet88@gmail.com"
  s.homepage = "http://github.com/wapcaplet/kelp"
  s.platform = Gem::Platform::RUBY

  s.add_dependency 'capybara', '>= 0.4.0'

  s.add_development_dependency 'sinatra'
  s.add_development_dependency 'rspec', '>= 2.2.0'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rcov'

  s.files = `git ls-files`.split("\n")
  s.require_path = 'lib'
end
