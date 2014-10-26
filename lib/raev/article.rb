module Raev
  
  class Article  

    attr_reader :body
    attr_reader :doc
  
    def initialize(body)
      body = replace_non_breaking_space(body)
      
      @doc = Nokogiri::HTML::DocumentFragment.parse(body)
      
      @doc = remove_empty_paragraphs(@doc)
      @doc = remove_extra_linebreaks(@doc)

      @body = @doc.to_s
    end

    private
    
    def replace_non_breaking_space(str)
      str.gsub("&nbsp;", " ")
    end
    
    def remove_empty_paragraphs(doc)
      doc.css("p").each do |node|
        if node_empty?(node)
          node.remove
        end
      end
      
      doc
    end
    
    def remove_extra_linebreaks(doc)
      doc.css("br").each do |node|
        next_node = node.next
        
        if next_node
          if next_node.matches?("br") || node_empty?(next_node)
            node.remove
          end
        else
          node.remove
        end
      end

      doc
    end

    def node_empty?(node)
      node.element_children.empty? && /\A *\z/.match(node.inner_text)
    end

  end

end