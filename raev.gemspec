# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "raev"
  s.version = "0.1.12"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andreas Zecher"]
  s.date = "2014-11-18"
  s.description = "Fetch, parse and normalize meta data from websites."
  s.email = "andreas@madebypixelate.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/raev.rb",
    "lib/raev/article.rb",
    "lib/raev/author.rb",
    "lib/raev/parser.rb",
    "lib/raev/url.rb",
    "raev.gemspec",
    "test/helper.rb",
    "test/test_article.rb",
    "test/test_author.rb",
    "test/test_url.rb"
  ]
  s.homepage = "http://github.com/pixelate/raev"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.3"
  s.summary = "Fetch, parse and normalize meta data from websites."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.6.1"])
      s.add_runtime_dependency(%q<redirect_follower>, [">= 0.1.1"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.6.3"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<test-unit>, ["~> 2.5.4"])
      s.add_runtime_dependency(%q<redirect_follower>, [">= 0.1.1"])
    else
      s.add_dependency(%q<nokogiri>, [">= 1.6.1"])
      s.add_dependency(%q<redirect_follower>, [">= 0.1.1"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.6.3"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<test-unit>, ["~> 2.5.4"])
      s.add_dependency(%q<redirect_follower>, [">= 0.1.1"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 1.6.1"])
    s.add_dependency(%q<redirect_follower>, [">= 0.1.1"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.6.3"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<test-unit>, ["~> 2.5.4"])
    s.add_dependency(%q<redirect_follower>, [">= 0.1.1"])
  end
end

