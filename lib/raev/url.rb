module Raev
  
  class Url
  
    attr_reader :url
  
    def initialize(url)
      @url = url
    end

    def base
      @url.split('/')[2].gsub('www.', '')
    end
    
    def clean
      utm_index = @url.index(/(\?|&)utm_/)
      unless(utm_index.nil?)
        return url.slice(0, utm_index)
      end
      
      @url
    end
    
    def resolved
      begin
        RedirectFollower(@url, 3)
      rescue => ex
        puts "Could not resolve #{url}. #{ex.class}: #{ex.message}"
        @url
      end
    end
    
    def resolved_and_clean
      resolved_url = Url.new(self.resolved)
      resolved_url.clean      
    end
  
  end

end