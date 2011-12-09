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
referef.search_engine # => SearchEngineReferer::GOOGLE
referer.page # => 3
referer.query # => 'ruby'
```
