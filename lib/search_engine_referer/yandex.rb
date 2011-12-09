module SearchEngineReferer
  class Yandex < Base
    def search_engine
      YANDEX
    end

    def page
      params['p'].to_i + 1
    end

    protected

    def user_query_key
      'text'
    end
  end
end
