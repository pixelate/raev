# encoding: UTF-8

require 'helper'
require 'raev/author'
require 'raev/url'

class TestRaev < Test::Unit::TestCase
  should "parse base url" do
    url = Raev::Url.new("http://indiegames.com/2011/05/c418_minecraft_volume_alpha.html")
    assert_equal url.base, "indiegames.com"
  end
  
  should "clean url" do
    url = Raev::Url.new("http://ipodtouchlab.com/2011/01/iphone-ipad-app-sale-20110117.html?utm_campaign=touch_lab_bot&utm_medium=twitter&utm_source=am6_feedtweet")
    assert_equal "http://ipodtouchlab.com/2011/01/iphone-ipad-app-sale-20110117.html", url.clean
    
    url = Raev::Url.new("http://games.ign.com/articles/117/1178937p1.html?RSSwhen2011-06-24_082700&RSSid=1178937&utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+ignfeeds%2Fgames+%28IGN+Videogames%29")
    assert_equal "http://games.ign.com/articles/117/1178937p1.html?RSSwhen2011-06-24_082700&RSSid=1178937", url.clean 
    
    url = Raev::Url.new("http://boingboing.net/2011/08/09/ea-tried-to-buy-minecraft-studio.html")
    assert_equal "http://boingboing.net/2011/08/09/ea-tried-to-buy-minecraft-studio.html", url.clean
  end  
  
  should "resolve url" do
    url = Raev::Url.new("http://feedproxy.google.com/~r/fingergaming/~3/nBkNwBLq-U8/")
    assert_equal "http://www.gamasutra.com/topic/smartphone-tablet/fg/2011/01/21/zynga-acquires-drop7-developer-areacode/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+fingergaming+%28FingerGaming%29", url.resolved
  end
  
  should "resolve and clean url" do 
    url = Raev::Url.new("http://feedproxy.google.com/~r/fingergaming/~3/nBkNwBLq-U8/")
    assert_equal "http://www.gamasutra.com/topic/smartphone-tablet/fg/2011/01/21/zynga-acquires-drop7-developer-areacode/", url.resolved_and_clean    
  end
  
  should "get twitter handle" do
    url = Raev::Url.new("http://www.polygon.com")
    assert_equal "polygon", url.twitter
  
    url = Raev::Url.new("http://penny-arcade.com/report")
    assert_equal "thepareport", url.twitter
  
    url = Raev::Url.new("http://kotaku.com")
    assert_equal nil, url.twitter
  end
  
  should "get rss feed" do
    url = Raev::Url.new("http://www.polygon.com")
    assert_equal "http://www.polygon.com/rss/index.xml", url.feed
    
    url = Raev::Url.new("http://penny-arcade.com/report")
    assert_equal "http://feeds.penny-arcade.com/pa-report", url.feed
  
    url = Raev::Url.new("http://arstechnica.com")
    assert_equal "http://feeds.arstechnica.com/arstechnica/index/", url.feed
  
    url = Raev::Url.new("http://www.edge-online.com")
    assert_equal "http://www.edge-online.com/feed/", url.feed
  end
  
  should "get twitter and rss feed" do
    url = Raev::Url.new("http://www.polygon.com")
    assert_equal "http://www.polygon.com/rss/index.xml", url.feed
    assert_equal "polygon", url.twitter    
  end
  
  should "parse author from rss entry" do
    assert_equal "Andreas", Raev::Author.parse_from_rss_entry("andreas@promoterapp.com (Andreas)")
  end
end