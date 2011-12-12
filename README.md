#SearchEngineReferer
Get meta information from search engine`s referer for google.com and yandex.ru

##Instalation
Add folowing line to Gemfile and then run `bundle` command.

```ruby
gem 'search_engine_referer'
```

##Usage
In your code use:

```ruby
referer = SearchEngineReferer.parse('http://google.com?q=ruby&start=20')
referef.search_engine # => :google
referer.page # => 3
referer.query # => 'ruby'
```

##Controller Helpers
Its add helpers for controllers and views: `search_engine_referer`
and `search_engine_query` and also method `search_engine_referer_source` for
referer source manipulations.

**`search_engine_referer_source`**
Looks into params first and use value with key :search_engine_referer if its present.
In other case it takes referer from request.
