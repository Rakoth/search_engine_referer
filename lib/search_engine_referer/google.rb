module SearchEngineReferer
  class Google < Base
    DEFAULT_RESULTS_PER_PAGE = 10
    HOST_PATTERN = /^(www\.)?google\./

    protected

    def page!
      params['start'].to_i / results_per_page + 1
    end

    def user_query_key
      'q'
    end

    def results_per_page
      result = params['num'].to_i
      result.zero? ? DEFAULT_RESULTS_PER_PAGE : result
    end
  end
end
