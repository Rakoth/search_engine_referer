require 'search_engine_referer/version'
require 'search_engine_referer/base'
require 'search_engine_referer/google'
require 'search_engine_referer/bing'
require 'search_engine_referer/yandex'
require 'search_engine_referer/mailru'
require 'search_engine_referer/rambler'
require 'search_engine_referer/railtie' if defined? Rails

module SearchEngineReferer
  class << self
    def parse referer_string
      Base.factory(referer_string)
    end

    def engines
      [Google, Bing, Yandex, Mailru, Rambler]
    end

    def engine_names
      engines.map(&:name)
    end
  end
end
