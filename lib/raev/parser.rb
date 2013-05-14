module Raev
  
  class Parser  

    def match_href list, expression
      list.find_all { |node| node['href'] =~ /#{expression}/ }
    end

  end
end