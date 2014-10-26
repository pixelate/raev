# encoding: UTF-8

require 'helper'
require 'raev'

class TestArticle < Test::Unit::TestCase
  should "remove empty paragraphs" do
    body = "<p>This paragraph has content.</p><p></p><p>&nbsp;</p><p><img></p>"
    
    article = Raev.article(body)
    
    assert_equal "<p>This paragraph has content.</p><p><img></p>", article.body
  end
  
  should "remove extra linebreaks" do
    body = "<p>Some text.<br><br><br/>Some more text.<br>&nbsp;&nbsp; <br></p>"
    
    article = Raev.article(body)
    
    assert_equal "<p>Some text.<br>Some more text.   </p>", article.body
  end
end