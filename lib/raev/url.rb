module Raev
  
  class Url
  
    attr_reader :url
  
    def initialize(url)
      @url = url
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
  
  end

end