require 'uri'
require 'rack/utils'

module SearchEngineReferer
  class Base
    def self.factory referer_string
      parser_class = case referer_string
      when /google/
        Google
      when /yandex/
        Yandex
      else
        raise UnknownSearchEngineError.new(
          "No Search Engine parser for referer: #{referer_string}"
        )
      end

      parser_class.new(referer_string)
    end

    def initialize referer_string
      @source = referer_string
    end

    attr_reader :source

    def query
      params[user_query_key].to_s.strip
    end

    def search_engine
      raise NotImplementedError
    end

    def to_hash
      {
        :source => source,
        :query => query,
        :page => page,
        :search_engine => search_engine
      }
    end

    protected

    def url
      @url ||= URI.parse(source)
    end

    def user_query_key
      raise NotImplementedError
    end

    def params
      @params ||= Rack::Utils.parse_query(url.query)
    end
  end
end
