require 'active_support/concern'
require 'active_support/core_ext/object/try'

module SearchEngineReferer
  module ControllerHelper
    extend ActiveSupport::Concern

    included do
      helper_method :search_engine_referer, :search_engine_query
    end

    protected

    def search_engine_referer
      @search_engine_referer ||= (
        env['search_engine_referer'] ||
          SearchEngineReferer.parse(search_engine_referer_source)
      )
    end

    def search_engine_query
      search_engine_referer.try(:query) || ''
    end

    def search_engine_referer_source
      request.referer
    end
  end
end
