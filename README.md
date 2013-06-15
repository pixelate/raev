Raev
====

Raev is a Ruby gem for fetching, parsing and normalizing meta data from websites. It was extracted from http://promoterapp.com.

Usage
-----

Get the domain name from an url without the *www.* subdomain.

```ruby
Raev::Url.new("http://indiegames.com/2011/05/c418_minecraft_volume_alpha.html").base
# => "indiegames.com"
```

Remove UTM analytics parameters from an url.

```ruby
Raev::Url.new("http://ipodtouchlab.com/2011/01/iphone-ipad-app-sale-20110117.html?utm_campaign=touch_lab_bot&utm_medium=twitter&utm_source=am6_feedtweet").clean
# =>  "http://ipodtouchlab.com/2011/01/iphone-ipad-app-sale-20110117.html"
```

Resolve a shortend or proxied url.

```ruby
Raev::Url.new("http://sbn.to/WRgXfl").resolved
# => "http://www.polygon.com/features/2013/3/25/4128022/gdc-gathering-of-game-makers"
```

Resolve a shortend or proxied url and remove UTM analytics parameters.

```ruby
url = Raev::Url.new("http://feedproxy.google.com/~r/fingergaming/~3/nBkNwBLq-U8/").resolved_and_clean 
# => "http://www.gamasutra.com/topic/smartphone-tablet/fg/2011/01/21/zynga-acquires-drop7-developer-areacode/"   
```

Fetch Twitter handle from url.

```ruby
Raev::Url.new("http://www.polygon.com").twitter
# => "polygon"
```

Fetch RSS feed from url.

```ruby
Raev::Url.new("http://www.polygon.com").feed
# => "http://www.polygon.com/rss/index.xml"
```

Normalize author name. Capitalizes name, strips whitespace, ignores email addresses and removes silly nicknames in quotes. Returns nil for empty strings or non-names like *Editor* or *Staff*.

Raev::Author.normalize_name("andreas@somedomain.com (Andreas)"
# => "Andreas"

Raev::Author.normalize_name("andreas")
# => "Andreas"

Raev::Author.normalize_name("Andreas 'Pixelate' Zecher")
# => "Andreas Zecher"

Raev::Author.normalize_name("Editor")
# => nil

Raev::Author.normalize_name(" ")
# => nil