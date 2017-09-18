module Raev
  
  class Author  

    NO_AUTHOR_STRINGS = [
      "admin".freeze,
      "blogs".freeze,
      "editor".freeze,
      "staff".freeze
    ]

    def self.normalize_name author_name
      if author_name.nil?
        return nil
      else
        # Strip whitespace
        author = author_name.strip
        if author.empty?
          return nil
        end
        
        # Ignore common strings that are not names of people        
        if NO_AUTHOR_STRINGS.include?(author.downcase)
          return nil
        end
      end
            
      # Parse notation "andreas@somedomain.com (Andreas)"
      m = /\((.*)\)/.match(author)
      unless m.nil?
        author = m[1]
      end

      # Remove nickname quotes
      author = author.gsub(/\"(.*)\"/, "".freeze).gsub(/\'(.*)\'/, "".freeze).gsub("  ".freeze, " ".freeze)

			# Remove "by"
			author = author.gsub("by ".freeze, "".freeze)

      # Capitalize
      return author.split(' '.freeze).map(&:capitalize).join(' '.freeze)
    end

  end
end