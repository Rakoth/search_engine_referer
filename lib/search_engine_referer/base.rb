require 'uri'
require 'rack/utils'

module SearchEngineReferer
  class Base
    def self.factory referer_string
      url = URI.parse(referer_string)
      parser_class = case url.host
      when /google/
        Google
      when /yandex/
        Yandex
      else
        return
      end

      parser_class.new(url)
    rescue URI::InvalidURIError
      nil
    end

    def initialize url_or_referer
      @url = url_or_referer if url_or_referer.is_a?(URI)
      @source = url_or_referer.to_s
    end

    attr_reader :source

    def query
      query!.strip
    end

    def search_engine
      raise NotImplementedError
    end

    def page
      @page ||= page!
    end

    def to_hash
      {
        :search_engine => search_engine,
        :source => source,
        :query => query,
        :page => page
      }
    end

    def == other
      source == other.source
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

    def query!
      params[user_query_key] || ''
    end
  end
end
