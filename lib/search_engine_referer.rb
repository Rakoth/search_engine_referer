require 'search_engine_referer/version'
require 'search_engine_referer/base'
require 'search_engine_referer/yandex'
require 'search_engine_referer/google'

module SearchEngineReferer
  class UnknownSearchEngineError < ArgumentError; end
  YANDEX = :yandex
  GOOGLE = :google

  def self.parse referer_string
    Base.factory(referer_string)
  rescue UnknownSearchEngineError
    nil
  end
end
