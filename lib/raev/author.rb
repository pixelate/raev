module Raev
  
  class Author  

    def self.parse_from_rss_entry entry_author
      if entry_author.nil?
        return nil
      else
        author = entry_author.strip
        
        no_authors = ["blogs", "editor", "staff"]
        
        if no_authors.include?(author.downcase)
          return nil
        end
      end
            
      # andreas@promoterapp.com (Andreas)
      m = /\((.*)\)/.match(author)
      unless m.nil?
        author = m[1]
      end

      return author
    end

  end
end

# Remove quotes