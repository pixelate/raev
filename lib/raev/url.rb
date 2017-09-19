require "chronic"
require "json"
require "sanitize"
require 'net/http'

module Raev
  
  class Url

    AUTHOR_CSS_SELECTORS = [
      '.c-byline__item a'.freeze,
      '.author-info .name'.freeze,
      '.author-top a'.freeze,
			'.yt-user-info a'.freeze,
      'a[rel~="author"]'.freeze,
      'a[itemprop~="author"]'.freeze,
      '.author h3 a'.freeze,
      '.author'.freeze,
      '.posted-by a'.freeze,
      '.entryAuthor a'.freeze,
      'a.names'.freeze,
      'a.byline-author'.freeze,
      '.byline a'.freeze,
      '.author.vcard a'.freeze,
      'p.info a'.freeze,
      '.author-name'.freeze,
      '.upcased'.freeze,
      'a[rel~="nofollow"]'.freeze
    ]
    
    REGEX_UTM = /(\?|&)utm_/
    REGEX_URL_DATE = /[0-9]{4}\/[0-9]{1,2}\/[0-9]{1,2}/
    REGEX_ENTRY_DATE = /[^a-zA-Z0-9\s]/
    REGEX_PAGE_TITLE = / +/
    
    attr_reader :url
    attr_reader :body
    attr_reader :doc
  
    def initialize(url)
      @body = ""
      fetch(url)
      @url = Url.remove_utm(@url)
      @doc = nil
      @linked_data = nil
    end

    def self.base(url)
      base_url = url.split('/'.freeze)[2]  
      base_url.gsub!('www.'.freeze, ''.freeze) unless base_url.nil?
      base_url
    end
    
    def self.remove_utm(url)
      unless url.nil?
        utm_index = url.index(REGEX_UTM)
        unless(utm_index.nil?)
          url = url.slice(0, utm_index)
        end
      end
      
      url
    end
    
    def without_http
      @url.sub("http://".freeze, "".freeze)
    end
    
    def twitter
      node = document.css('a:match_href("twitter.com")'.freeze, Raev::Parser.new)
            
      if node.first
        twitter_url = node.first["href"]
        twitter_url.split('/'.freeze).last
      else
        nil
      end
    end
    
    def feed
      feed_url = nil
      
      node = document.css('link[type="application/rss+xml"][rel="alternate"]'.freeze)
      
      if node.first
        feed_url = node.first["href"]
      else
        node = document.css('a:match_href("http://feeds.")'.freeze, Raev::Parser.new)
                
        if node.first
          feed_url = node.first["href"]
        end
      end
      
      if feed_url && feed_url[0,1] == "/".freeze
        feed_url = @url + feed_url
      end
      
      feed_url
    end
    
    def headline
      if linked_data && linked_data["headline"]
        return Sanitize.clean(linked_data["headline"])
      end
      
      page_title = nil
      
      node = document.css(".twitter-share-button".freeze)
      
      if node.first
        if node.first['data-text']
          page_title = node.first['data-text']
        end
      end

      if page_title.nil?
        document.css("head meta".freeze).each do |meta|
          if meta['property'] == 'og:title'.freeze || meta['property'] == 'twitter:title'.freeze
            page_title = meta['content']
          end
        end
      end
            
      if page_title.nil?
        node = document.css("#article h1, a[rel=\"bookmark\"], h2[itemprop=\"name\"]".freeze)
                
        if node.first
          page_title = node.first.content
        end
      end
      
      unless page_title.nil?
        page_title.gsub!(REGEX_PAGE_TITLE, ' '.freeze)
      end
      
      page_title
    end
        
    def pubdate      
      if linked_data && linked_data["datePublished"]
        return Date.parse(linked_data["datePublished"])
      end
      
      date_elements = @url.match(REGEX_URL_DATE).to_s.split("/".freeze)
      
      if date_elements.size == 3
        return Date.new(date_elements[0].to_i, date_elements[1].to_i, date_elements[2].to_i)      
      else
        node = document.search("meta[itemprop='datePublished'], meta[name='pub_date']".freeze).first
        
        if node
          return Date.parse(node.attribute("content".freeze))
        else
          node = document.search(".entryDate, .entrydate".freeze).first

          if node
            return Chronic.parse(node.content.gsub(REGEX_ENTRY_DATE, "".freeze).strip)
          end
        end
      end
      
      nil
    end
    
    def author
			node = document.search('meta[name="author"]'.freeze).first

			if node && node.attribute("content".freeze)
				return node.attribute("content".freeze).value
			end
			
      node = document.search(AUTHOR_CSS_SELECTORS.join(", ".freeze)).first
      
      if node
        words = node.content.split.size
      
        if words <= 4
          return Sanitize.clean(node.content).strip[0..255]
        end
      end
      
      "".freeze
    end
		
		def ratingValue
			node = document.search('*[itemprop="ratingValue"]'.freeze).first
			
			if node
				if node.attribute("content".freeze)
					value = node.attribute("content".freeze).value
				else
					value = node.content
				end
			end

			if value
				value.to_f
			else
				nil
			end
		end
		
		def bestRating
			node = document.search('*[itemprop="bestRating"]'.freeze).first
			
			if node
				if node.attribute("content".freeze)
					value = node.attribute("content".freeze).value
				
					if value
						return value.to_f
					end
				end
			end
			
			nil			
		end

    def document
      if @doc.nil?
        @doc = Nokogiri::HTML(@body)
      end

      @doc
    end
		
    private
    
    def linked_data
      if @linked_data.nil?
        node = document.css("script[type=\"application/ld+json\"]".freeze)
      
        if node.first
          @linked_data = JSON.parse(node.first.content)
        end
      end
      
      @linked_data
    end
    
    def fetch(uri_str, limit = 10)
      raise ArgumentError, 'too many HTTP redirects' if limit == 0

      @url = uri_str unless uri_str.nil?
      
      response = Net::HTTP.get_response(URI(uri_str))

      case response
      when Net::HTTPSuccess then
        @body = response.body
      when Net::HTTPRedirection then
        fetch(response['location'], limit - 1)
      else
        # TODO handle Not Found
      end
    end
  end
end