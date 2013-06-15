Raev
====

Raev is a Ruby gem for fetching, parsing and normalizing meta data from websites. It was extracted from http://promoterapp.com.

Usage
-----

Get the domain name from an url without the `www.` subdomain.

```ruby
Raev::Url.new("http://indiegames.com/2011/05/c418_minecraft_volume_alpha.html").base
# => "indiegames.com"
```