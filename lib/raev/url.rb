require "json"
require "sanitize"

module Raev
  
  class Url
    attr_reader :url
    attr_reader :doc
    attr_reader :linked_data
  
    def initialize(url)
      @url = url
      @doc = nil
      @linked_data = nil
    end

    def base      
      base_url = @url.split('/')[2]  
      base_url = base_url.gsub('www.', '') unless base_url.nil?
      base_url
    end
    
    def clean
      unless @url.nil?
        utm_index = @url.index(/(\?|&)utm_/)
        unless(utm_index.nil?)
          return url.slice(0, utm_index)
        end
      end
      
      @url
    end
    
    def resolved
      unless @url.nil?
        begin
          return RedirectFollower(@url, 5)
        rescue => ex
          puts "Could not resolve #{@url}. #{ex.class}: #{ex.message}"
        end
      end

      @url
    end
    
    def resolved_and_clean
      resolved_url = Url.new(self.resolved)
      resolved_url.clean      
    end

    def without_http
      @url.sub("http://", "")
    end
    
    def twitter
      node = document.css('a:match_href("twitter.com")', Raev::Parser.new)
            
      if node.first
        twitter_url = node.first["href"]
        twitter_url.split('/').last
      else
        nil
      end
    end
    
    def feed
      feed_url = nil
      
      node = document.css('link[type="application/rss+xml"][rel="alternate"]')
      
      if node.first
        feed_url = node.first["href"]
      else
        node = document.css('a:match_href("http://feeds.")', Raev::Parser.new)
                
        if node.first
          feed_url = node.first["href"]
        end
      end
      
      if feed_url && feed_url[0,1] == "/"
        feed_url = @url + feed_url
      end
      
      feed_url
    end
    
    def headline
      if linked_data && linked_data["headline"]
        return Sanitize.clean(linked_data["headline"])
      end
      
      page_title = nil
      
      node = document.css(".twitter-share-button")
      
      if node.first
        if node.first['data-text']
          page_title = node.first['data-text']
        end
      end

      if page_title.nil?
        document.css("head meta").each do |meta|
          if meta['property'] == 'og:title' || meta['property'] == 'twitter:title'
            page_title = meta['content']
          end
        end
      end
            
      if page_title.nil?
        node = document.css("#article h1, a[rel=\"bookmark\"], h2[itemprop=\"name\"]")
                
        if node.first
          page_title = node.first.content
        end
      end
      
      unless page_title.nil?
        page_title.gsub!(/ +/, ' ')
      end
      
      page_title
    end
        
    private
    
    def document
      if @doc.nil?
        @doc = Nokogiri::HTML(open(@url))
      end

      @doc
    end
    
    def linked_data
      if @linked_data.nil?
        node = document.css("script[type=\"application/ld+json\"]")
      
        if node.first
          @linked_data = JSON.parse(node.first.content)
        end
      end
      
      @linked_data
    end
    
  end
end