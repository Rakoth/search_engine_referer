require 'search_engine_referer/controller_helper'

module SearchEngineReferer
  class Railtie < Rails::Railtie
    initializer 'search_engine_referer.controller_helper' do
      ActiveSupport.on_load :action_controller do
        include ControllerHelper
      end
    end
  end
end
