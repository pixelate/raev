# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: raev 0.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "raev".freeze
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andreas Zecher".freeze]
  s.date = "2017-09-19"
  s.description = "Fetch, parse and normalize meta data from websites.".freeze
  s.email = "andreas@madebypixelate.com".freeze
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
  s.homepage = "http://github.com/pixelate/raev".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.13".freeze
  s.summary = "Fetch, parse and normalize meta data from websites.".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>.freeze, [">= 2.1.0"])
      s.add_runtime_dependency(%q<nokogiri>.freeze, [">= 1.8.0"])
      s.add_runtime_dependency(%q<sanitize>.freeze, [">= 2.1.0"])
      s.add_runtime_dependency(%q<chronic>.freeze, [">= 0.10.2"])
      s.add_development_dependency(%q<shoulda>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.14.6"])
      s.add_development_dependency(%q<jeweler>.freeze, ["= 2.3.7"])
      s.add_development_dependency(%q<test-unit>.freeze, ["= 3.2.4"])
    else
      s.add_dependency(%q<json>.freeze, [">= 2.1.0"])
      s.add_dependency(%q<nokogiri>.freeze, [">= 1.8.0"])
      s.add_dependency(%q<sanitize>.freeze, [">= 2.1.0"])
      s.add_dependency(%q<chronic>.freeze, [">= 0.10.2"])
      s.add_dependency(%q<shoulda>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.14.6"])
      s.add_dependency(%q<jeweler>.freeze, ["= 2.3.7"])
      s.add_dependency(%q<test-unit>.freeze, ["= 3.2.4"])
    end
  else
    s.add_dependency(%q<json>.freeze, [">= 2.1.0"])
    s.add_dependency(%q<nokogiri>.freeze, [">= 1.8.0"])
    s.add_dependency(%q<sanitize>.freeze, [">= 2.1.0"])
    s.add_dependency(%q<chronic>.freeze, [">= 0.10.2"])
    s.add_dependency(%q<shoulda>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.14.6"])
    s.add_dependency(%q<jeweler>.freeze, ["= 2.3.7"])
    s.add_dependency(%q<test-unit>.freeze, ["= 3.2.4"])
  end
end

