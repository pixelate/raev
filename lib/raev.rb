require 'nokogiri'
require 'redirect_follower'
require 'open-uri'

require 'raev/author'
require 'raev/parser'
require 'raev/url'

module Raev
  def self.url url
    Raev::Url.new(url)
  end
  
  def self.normalize_author author_name
    Raev::Author.normalize_name(author_name)
  end
end