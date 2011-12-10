module SearchEngineReferer
  class Yandex < Base
    def search_engine
      YANDEX
    end

    protected

    def page!
      params['p'].to_i + 1
    end

    def user_query_key
      'text'
    end

    def query!
      result = super
      result = result.encode(Encoding::UTF_8, Encoding::CP1251) unless result.valid_encoding?
      result
    end
  end
end
