module Raev
  
  class Parser  

    def match_href list, expression
      list.find_all { |node| node['href'.freeze] =~ /#{expression}/ }
    end

  end
end