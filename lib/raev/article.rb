module Raev
  
  class Article  

    attr_reader :body
    attr_reader :doc
  
    def initialize(body)
      body = replace_non_breaking_space(body)
      
      @doc = Nokogiri::HTML::DocumentFragment.parse(body)
      
      @doc = remove_empty_paragraphs(@doc)

      @body = @doc.to_s
    end

    private
    
    def replace_non_breaking_space(str)
      str.gsub("&nbsp;", " ")
    end
    
    def remove_empty_paragraphs(doc)
      doc.css("p").each do |node|
        if node.element_children.empty? && /\A *\z/.match(node.inner_text)
          node.remove
        end
      end
      
      doc
    end

  end

end