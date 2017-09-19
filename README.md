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
Raev::Url.base("http://indiegames.com/2011/05/c418_minecraft_volume_alpha.html")
# => "indiegames.com"
```

Remove UTM analytics parameters from an url.

```ruby
Raev::Url.remove_utm("http://www.ign.com/articles/2011/06/24/new-controllers-for-the-disabled-debuts-and-promises-change&utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+ignfeeds%2Fgames+%28IGN+Videogames%29")
# =>  "http://www.ign.com/articles/2011/06/24/new-controllers-for-the-disabled-debuts-and-promises-change"
```

Resolve a shortened or proxied url.

```ruby
Raev.url("http://sbn.to/WRgXfl").url
# => "http://www.polygon.com/features/2013/3/25/4128022/gdc-gathering-of-game-makers"
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
review.bestRating
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