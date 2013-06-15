module Raev
  
  class Author  

    def self.normalize_name entry_author
      if entry_author.nil?
        return nil
      else
        # Strip whitespace
        author = entry_author.strip
        if author.empty?
          return nil
        end
        
        # Ignore common strings that are not names of people
        no_authors = ["admin", "blogs", "editor", "staff"]
        
        if no_authors.include?(author.downcase)
          return nil
        end
      end
            
      # Parse notation "andreas@somedomain.com (Andreas)"
      m = /\((.*)\)/.match(author)
      unless m.nil?
        author = m[1]
      end

      # Remove nickname quotes
      author = author.gsub(/\"(.*)\"/, "").gsub(/\'(.*)\'/, "").gsub("  ", " ")

      # Capitalize
      return author.split(' ').map(&:capitalize).join(' ')
    end

  end
end