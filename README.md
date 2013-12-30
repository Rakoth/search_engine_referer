#SearchEngineReferer
Get meta information from search engine`s referer for

* google.com
* bing.com
* yandex.ru
* go.mail.ru
* nova.rambler.ru

##Instalation
Add the folowing line to Gemfile and then run `bundle` command.

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

non_search_enfine_referer = SearchEngineReferer.parse('http://example.com?q=ruby')
non_search_enfine_referef # => nil
```

##Controller Helpers
Its add helpers for controllers and views: `search_engine_referer` and `search_engine_query`.

**`search_engine_referer_source`**
Method for referer source manipulations.
By default it returns `request.referer`. It can be overwritten in controller, for example:

```ruby
def search_engine_referer_source
  cookies[:search_engine_referer] || super
end
```

##Development
Fully tested pull requests are welcome.
