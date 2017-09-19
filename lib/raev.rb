require 'nokogiri'
require 'raev/article'
require 'raev/author'
require 'raev/parser'
require 'raev/url'

module Raev
  def self.url url
    Raev::Url.new(url)
  end

  def self.article body
    Raev::Article.new(body)
  end
  
  def self.normalize_author author_name
    Raev::Author.normalize_name(author_name)
  end
end