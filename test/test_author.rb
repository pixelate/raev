# encoding: UTF-8

require 'helper'
require 'raev'

class TestAuthor < Test::Unit::TestCase
  should "parse author from rss entry" do
    assert_equal "Andreas", Raev.normalize_author("andreas@somedomain.com (Andreas)")
    assert_equal "Andreas Zecher", Raev.normalize_author("Andreas \"Pixelate\" Zecher")
    assert_equal "Andreas Zecher", Raev.normalize_author("Andreas 'Pixelate' Zecher")
    assert_equal "Andreas", Raev.normalize_author("andreas")
    assert_equal nil, Raev.normalize_author("Admin")
    assert_equal nil, Raev.normalize_author("Blogs")
    assert_equal nil, Raev.normalize_author("Editor")
    assert_equal nil, Raev.normalize_author("Staff")
    assert_equal nil, Raev.normalize_author(" ")
    assert_equal nil, Raev.normalize_author(nil)
  end  
end