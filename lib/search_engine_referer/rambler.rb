module SearchEngineReferer
  class Rambler < Base
    HOST_PATTERN = /^(www\.)?(nova\.)?rambler\./

    protected

    def page!
      (params['page'] or 1).to_i
    end

    def user_query_key
      'query'
    end
  end
end
