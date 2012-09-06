module SearchEngineReferer
  class Bing < Base
    DEFAULT_RESULTS_PER_PAGE = 10
    HOST_PATTERN = /bing\./

    protected

    def page!
      params['first'].to_i / DEFAULT_RESULTS_PER_PAGE + 1
    end

    def user_query_key
      'q'
    end
  end
end
