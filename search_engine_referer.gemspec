# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'search_engine_referer/version'

Gem::Specification.new do |s|
  s.name = 'search_engine_referer'
  s.version = SearchEngineReferer::VERSION
  s.authors = ['Alexander Stanko']
  s.email = ['astanko@aviasales.ru']
  s.homepage = 'http://github.com/Rakoth/search_engine_referer'
  s.summary = %q{Parse search engine referer}
  s.description = %q{
    Help to parse referer url for get user search query and page of search engine results.
    Work with Google and Yandex for now.
  }

  s.rubyforge_project = 'search_engine_referer'

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'activesupport'
  s.add_development_dependency 'rack-test'
  s.add_runtime_dependency 'rack'
end
