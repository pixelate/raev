module Raev
  
  class Author  

    NO_AUTHOR_STRINGS = [
      "admin".freeze,
      "blogs".freeze,
      "editor".freeze,
      "staff".freeze
    ]
    
    REGEX_EMAIL_WITH_NAME = /\((.*)\)/
    REGEX_QUOTES = /\'(.*)\'/
    REGEX_DOUBLE_QUOTES = /\"(.*)\"/

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
      m = REGEX_EMAIL_WITH_NAME.match(author)
      unless m.nil?
        author = m[1]
      end
      
      # Remove nickname quotes
      author.gsub!(REGEX_DOUBLE_QUOTES, "".freeze)
      author.gsub!(REGEX_QUOTES, "".freeze)
      author.gsub!("  ".freeze, " ".freeze)

			# Remove "by"
			author.gsub!("by ".freeze, "".freeze)

      # Capitalize
      return author.split(' '.freeze).map(&:capitalize).join(' '.freeze)
    end

  end
end