module SearchEngineReferer
  class Google < Base
    DEFAULT_RESULTS_PER_PAGE = 10

    def search_engine
      GOOGLE
    end

    def page
      params['start'].to_i / results_per_page + 1
    end

    protected

    def user_query_key
      'q'
    end

    def results_per_page
      result = params['num'].to_i
      result.zero? ? DEFAULT_RESULTS_PER_PAGE : result
    end
  end
end
