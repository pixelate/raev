require "chronic"
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
        
    def pubdate      
      if linked_data && linked_data["datePublished"]
        return Date.parse(linked_data["datePublished"])
      end
      
      date_elements = @url.match(/[0-9]{4}\/[0-9]{1,2}\/[0-9]{1,2}/).to_s.split("/")
      
      if date_elements.size == 3
        return Date.new(date_elements[0].to_i, date_elements[1].to_i, date_elements[2].to_i)      
      else
        node = document.search("meta[itemprop='datePublished'], meta[name='pub_date']").first
        
        if node
          return Date.parse(node.attribute("content"))
        else
          node = document.search(".entryDate, .entrydate").first

          if node
            return Chronic.parse(node.content.gsub(/[^a-zA-Z0-9\s]/,"").strip)
          end
        end
      end
      
      nil
    end
    
    def author
      cssSelectors = [
        '.author-info .name',
        '.author-top a',
				'.yt-user-info a',
        'a[rel~="author"]',
        'a[itemprop~="author"]',
        '.author h3 a',
        '.author',
        '.posted-by a',
        '.entryAuthor a',
        'a.names',
        'a.byline-author',
        '.byline a',
        '.author.vcard a',
        'p.info a',
        '.author-name',
        '.upcased',
        'a[rel~="nofollow"]'
      ]

      node = document.search(cssSelectors.join(", ")).first
      
      if node
        words = node.content.split.size
      
        if words <= 4
          return Sanitize.clean(node.content).strip[0..255]
        end
      end
      
      ""
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