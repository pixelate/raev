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
    assert_equal "https://www.gamasutra.com/topic/smartphone-tablet/fg/2011/01/21/zynga-acquires-drop7-developer-areacode/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+fingergaming+%28FingerGaming%29", url.resolved
  end
  
  should "resolve and clean url" do 
    url = Raev.url("http://feedproxy.google.com/~r/fingergaming/~3/nBkNwBLq-U8/")
    assert_equal "https://www.gamasutra.com/topic/smartphone-tablet/fg/2011/01/21/zynga-acquires-drop7-developer-areacode/", url.resolved_and_clean    
  end
  
  should "get twitter handle" do
    url = Raev.url("https://www.polygon.com")
    assert_equal "Polygon", url.twitter
  end
  
  should "get rss feed" do
    url = Raev.url("http://www.polygon.com")
    assert_equal "http://www.polygon.com/rss/index.xml", url.feed
    
    url = Raev.url("http://arstechnica.com")
    assert_equal "http://feeds.arstechnica.com/arstechnica/index/", url.feed
  
    url = Raev.url("http://www.kotaku.com")
    assert_equal "https://kotaku.com/rss", url.feed
  end
  
  should "get headline from url" do
    url = Raev.url("https://www.polygon.com/e3-2013/2013/6/14/4429126/the-indie-eight-ps4")
    assert_equal "The Indie Eight: Polygon talks with the showcase indies launching on PS4", url.headline

    url = Raev.url("https://kotaku.com/the-world-of-a-link-to-the-past-has-changed-in-the-new-513424187")
    assert_equal "The World of A Link To The Past Has Changed in the New 3DS Zelda", url.headline
    
    url = Raev.url("http://arstechnica.com/gaming/2012/03/journey-a-hauntingly-beautiful-art-house-film-disguised-as-a-game/")
    assert_equal "Journey: A hauntingly beautiful art house film disguised as a game", url.headline

    url = Raev.url("http://www.creativeapplications.net/games/below-new-from-the-creators-of-sword-sworcery/")
    assert_equal "Below – New from the creators of Sword & Sworcery", url.headline

    url = Raev.url("http://www.giantbomb.com/videos/e3-2013-fez-ii-announcement-teaser/2300-7606/")
    assert_equal "E3 2013: Fez II Announcement Teaser", url.headline

    url = Raev.url("http://indiegames.com/2013/06/indie_fund_backing_for_two_new.html")
    assert_equal "Indie Fund backing two new titles for Double Fine", url.headline

    url = Raev.url("https://killscreen.com/articles/news/cheat-sheet-614/")
    assert_equal "Pixels on canvas, Spielberg's predictions, and Polytron's glorious tease - Kill Screen", url.headline

    url = Raev.url("https://www.rockpapershotgun.com/2013/06/05/i-spy-an-open-beta-for-spy-party/")
    assert_equal "I Spy An Open Beta For Spy Party", url.headline
  end
  
  should "get pubdate from url" do
    url = Raev.url("https://www.polygon.com/2015/5/18/8620223/witcher-3-guide-witcher-2-witcher")
    assert_equal_date Date.new(2015, 5, 18), url.pubdate
    
    url = Raev.url("https://kotaku.com/this-week-destiny-got-a-hell-of-a-lot-better-1706391634")
    assert_equal_date Date.new(2015, 5, 23), url.pubdate
    
    url = Raev.url("https://www.rockpapershotgun.com/2014/07/03/beauty-beheld-future-unfolding/")
    assert_equal_date Date.new(2014, 7, 3), url.pubdate
    
    url = Raev.url("https://jayisgames.com/review/the-black-forest-finding-friends.php")
    assert_equal_date Date.new(2009, 12, 9), url.pubdate
    
    url = Raev.url("http://www.wired.com/2014/09/upcoming-a-gorgeous-adventure-game-that-mutates-for-each-player/")
    assert_equal_date Date.new(2014, 9, 4), url.pubdate
    
    url = Raev.url("http://www.pcgamer.com/harebrained-schemes-hints-at-something-new-from-an-old-franchise/")
    assert_equal_date Date.new(2015, 5, 21), url.pubdate    
  end
  
  should "get author from url" do
    url = Raev.url("https://www.rockpapershotgun.com/2014/07/03/beauty-beheld-future-unfolding/")
    assert_equal "Adam Smith", url.author
    
    url = Raev.url("http://www.polygon.com/features/2013/3/25/4128022/gdc-gathering-of-game-makers")
    assert_equal "Colin Campbell", url.author
    
    url = Raev.url("https://kotaku.com/worth-reading-some-kickstarters-are-lying-about-game-b-1706340013")
    assert_equal "Patrick Klepek", url.author
    
    url = Raev.url("https://killscreen.com/articles/future-unfolding-wonder/")
    assert_equal "Jess Joho", url.author
    
    url = Raev.url("http://www.creativeapplications.net/games/future-unfolding-procedurally-generated-world-both-beautiful-and-dangerous/")
    assert_equal "Filip Visnjic", Raev::normalize_author(url.author)
		
		url = Raev.url("https://www.youtube.com/watch?v=FmZYPMsq5m4")
		assert_equal "PsiSyn", url.author
  end
	
	should "get score" do
		url = Raev.url("http://www.slantmagazine.com/games/review/shadow-of-the-beast")
		assert_equal 4.0, url.ratingValue
		assert_equal 5, url.bestRating
		
		url = Raev.url("http://www.gamesradar.com/superhot-review/")
		assert_equal 4.5, url.ratingValue
		assert_equal 5, url.bestRating
		
		url = Raev.url("http://www.gameswelt.de/shadow-of-the-beast/test/klassiker-im-neuen-gewand,257932")
		assert_equal 8, url.ratingValue
		assert_equal 10, url.bestRating
	end
  
  private
  
  def assert_equal_date dateA, dateB
    assert_equal dateA.strftime('%Y-%m-%d'), dateB.strftime('%Y-%m-%d')
  end
  
end