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
  
  should "transform div to p tags" do
    body = "<div>Some paragraph.</div><div>Another paragraph.</div>"
    
    article = Raev.article(body)
    
    assert_equal "<p>Some paragraph.</p><p>Another paragraph.</p>", article.body
  end
  
  should "not transform div to p tags if they have p children" do
    body = "<div><p>Some paragraph.</p><p>Another paragraph.</p></div>"
    
    article = Raev.article(body)
    
    assert_equal "<div><p>Some paragraph.</p><p>Another paragraph.</p></div>", article.body
  end
end