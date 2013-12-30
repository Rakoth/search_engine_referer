module SearchEngineReferer
  class Middleware
    def initialize app, referer_source = nil, &block
      @app = app
      @referer_source = referer_source || block
    end

    def call env
      env['search_engine_referer'] = SearchEngineReferer.parse(referer(env))
      @app.call(env)
    end

    private

    def referer env
      case
      when env.key?(@referer_source)
        env[@referer_source]
      when @referer_source.respond_to?(:call)
        @referer_source.call(env)
      else
        env['HTTP_REFERER']
      end
    end
  end
end
