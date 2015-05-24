# encoding: UTF-8

require 'helper'
require 'raev'

class UrlTest < Test::Unit::TestCase
  should "parse base url" do
    url = Raev.url("http://indiegames.com/2011/05/c418_minecraft_volume_alpha.html")
    assert_equal url.base, "indiegames.com"
  end
  
  should "clean url" do
    url = Raev.url("http://ipodtouchlab.com/2011/01/iphone-ipad-app-sale-20110117.html?utm_campaign=touch_lab_bot&utm_medium=twitter&utm_source=am6_feedtweet")
    assert_equal "http://ipodtouchlab.com/2011/01/iphone-ipad-app-sale-20110117.html", url.clean
    
    url = Raev.url("http://games.ign.com/articles/117/1178937p1.html?RSSwhen2011-06-24_082700&RSSid=1178937&utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+ignfeeds%2Fgames+%28IGN+Videogames%29")
    assert_equal "http://games.ign.com/articles/117/1178937p1.html?RSSwhen2011-06-24_082700&RSSid=1178937", url.clean 
    
    url = Raev.url("http://boingboing.net/2011/08/09/ea-tried-to-buy-minecraft-studio.html")
    assert_equal "http://boingboing.net/2011/08/09/ea-tried-to-buy-minecraft-studio.html", url.clean
  end  
  
  should "resolve url" do
    url = Raev.url("http://feedproxy.google.com/~r/fingergaming/~3/nBkNwBLq-U8/")
    assert_equal "http://www.gamasutra.com/topic/smartphone-tablet/fg/2011/01/21/zynga-acquires-drop7-developer-areacode/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+fingergaming+%28FingerGaming%29", url.resolved
  end
  
  should "resolve and clean url" do 
    url = Raev.url("http://feedproxy.google.com/~r/fingergaming/~3/nBkNwBLq-U8/")
    assert_equal "http://www.gamasutra.com/topic/smartphone-tablet/fg/2011/01/21/zynga-acquires-drop7-developer-areacode/", url.resolved_and_clean    
  end
  
  should "get twitter handle" do
    url = Raev.url("http://polygon.com")
    assert_equal nil, url.twitter
  end
  
  should "get rss feed" do
    url = Raev.url("http://www.polygon.com")
    assert_equal "http://www.polygon.com/rss/index.xml", url.feed
    
    url = Raev.url("http://arstechnica.com")
    assert_equal "http://feeds.arstechnica.com/arstechnica/index/", url.feed
  
    url = Raev.url("http://www.kotaku.com")
    assert_equal "http://feeds.gawker.com/kotaku/full", url.feed
  end
  
  should "get headline from url" do
    url = Raev.url("http://www.polygon.com/e3-2013/2013/6/14/4429126/the-indie-eight-ps4")
    assert_equal "The Indie Eight: Polygon talks with the showcase indies launching on PS4", url.headline

    url = Raev.url("http://kotaku.com/the-world-of-a-link-to-the-past-has-changed-in-the-new-513424187")
    assert_equal "The World of A Link To The Past Has Changed in the New 3DS Zelda", url.headline
    
    url = Raev.url("http://arstechnica.com/gaming/2012/03/journey-a-hauntingly-beautiful-art-house-film-disguised-as-a-game/")
    assert_equal "Journey: A hauntingly beautiful art house film disguised as a game", url.headline

    url = Raev.url("http://www.creativeapplications.net/games/below-new-from-the-creators-of-sword-sworcery/")
    assert_equal "Below – New from the creators of Sword & Sworcery", url.headline

    url = Raev.url("http://www.giantbomb.com/videos/e3-2013-fez-ii-announcement-teaser/2300-7606/")
    assert_equal "E3 2013: Fez II Announcement Teaser", url.headline

    url = Raev.url("http://indiegames.com/2013/06/indie_fund_backing_for_two_new.html")
    assert_equal "Indie Fund backing two new titles for Double Fine", url.headline

    url = Raev.url("http://killscreendaily.com/articles/news/cheat-sheet-614/")
    assert_equal "Pixels on canvas, Spielberg's predictions, and Polytron's glorious tease", url.headline

    url = Raev.url("http://www.rockpapershotgun.com/2013/06/05/i-spy-an-open-beta-for-spy-party/")
    assert_equal "I Spy An Open Beta For Spy Party", url.headline
  end  
end