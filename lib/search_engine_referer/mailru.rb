module SearchEngineReferer
  class Mailru < Base
    DEFAULT_RESULTS_PER_PAGE = 10
    HOST_PATTERN = /go\.mail\.ru/

    protected

    def page!
      params['sf'].to_i / DEFAULT_RESULTS_PER_PAGE + 1
    end

    def user_query_key
      'q'
    end
  end
end
