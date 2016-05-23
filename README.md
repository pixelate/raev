Raev
====

Raev is a Ruby gem for fetching, parsing and normalizing meta data from websites. It was extracted from http://promoterapp.com.

Install
--------

```shell
gem install raev
```
or add the following line to Gemfile:

```ruby
gem 'raev'
```
and run `bundle install` from your shell.

Usage
-----

Get the domain name from an url without the `www.` subdomain.

```ruby
Raev.url("http://indiegames.com/2011/05/c418_minecraft_volume_alpha.html").base
# => "indiegames.com"
```

Remove UTM analytics parameters from an url.

```ruby
Raev.url("http://ipodtouchlab.com/2011/01/iphone-ipad-app-sale-20110117.html?utm_campaign=touch_lab_bot&utm_medium=twitter&utm_source=am6_feedtweet").clean
# =>  "http://ipodtouchlab.com/2011/01/iphone-ipad-app-sale-20110117.html"
```

Resolve a shortened or proxied url.

```ruby
Raev.url("http://sbn.to/WRgXfl").resolved
# => "http://www.polygon.com/features/2013/3/25/4128022/gdc-gathering-of-game-makers"
```

Resolve a shortend or proxied url and remove UTM analytics parameters.

```ruby
url = Raev.url("http://feedproxy.google.com/~r/fingergaming/~3/nBkNwBLq-U8/").resolved_and_clean 
# => "http://www.gamasutra.com/topic/smartphone-tablet/fg/2011/01/21/zynga-acquires-drop7-developer-areacode/"   
```

Fetch Twitter handle from url.

```ruby
Raev.url("http://www.polygon.com").twitter
# => "polygon"
```

Fetch RSS feed from url.

```ruby
Raev.url("http://www.polygon.com").feed
# => "http://www.polygon.com/rss/index.xml"
```

Fetch headline from url. Removes double spaces.

```ruby
Raev.url("http://www.polygon.com/e3-2013/2013/6/14/4429126/the-indie-eight-ps4").headline
# => "The Indie Eight: Polygon talks with the showcase indies launching on PS4"
```

Parse review scores.

```ruby
review = Raev.url("http://www.gamesradar.com/superhot-review/")
review.ratingValue
# => 4.5
review.review.bestRating
# => 5.0
```

Normalize author name. Capitalizes name, strips whitespace, ignores email addresses and removes silly nicknames in quotes. Returns nil for empty strings or non-names like *Editor* or *Staff*.

```
Raev.normalize_author("andreas@somedomain.com (Andreas)")
# => "Andreas"

Raev.normalize_author("andreas")
# => "Andreas"

Raev.normalize_author("Andreas 'Pixelate' Zecher")
# => "Andreas Zecher"

Raev.normalize_author("Editor")
# => nil

Raev.normalize_author(" ")
# => nil
```

[![Code Climate](https://codeclimate.com/github/pixelate/raev/badges/gpa.svg)](https://codeclimate.com/github/pixelate/raev)