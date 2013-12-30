require 'spec_helper'
require 'search_engine_referer/middleware'
require 'rack/test'

describe SearchEngineReferer::Middleware do
  include Rack::Test::Methods

  describe 'referer source initialization' do
    context 'env key' do
      let(:app) do
        Rack::Builder.new do
          use SearchEngineReferer::Middleware, 'HTTP_CUSTOM_REFERER'
          run lambda{|env| [200, {:referer => env['search_engine_referer']}, ['OK']]}
        end
      end

      it 'uses custom env key' do
        get '/', {}, 'HTTP_CUSTOM_REFERER' => 'http://google.com?q=test'
        last_response[:referer].should be
        last_response[:referer].search_engine.should == :google
      end
    end

    context 'env proc' do
      let(:app) do
        Rack::Builder.new do
          use SearchEngineReferer::Middleware do |env|
            env['HTTP_CUSTOM_REFERER'] || env['HTTP_REFERER']
          end

          run lambda{|env| [200, {:referer => env['search_engine_referer']}, ['OK']]}
        end
      end

      it 'uses proc to evaluate referer from env' do
        get '/', {},
          'HTTP_CUSTOM_REFERER' => 'http://google.com?q=test',
          'HTTP_REFERER' => 'http://bing.com?q=test1'
        last_response[:referer].should be
        last_response[:referer].search_engine.should == :google
      end

      it 'uses proc to evaluate referer from env on every request' do
        get '/', {}, 'HTTP_REFERER' => 'http://bing.com?q=test1'
        last_response[:referer].should be
        last_response[:referer].search_engine.should == :bing
      end
    end

    context 'default' do
      let(:app) do
        Rack::Builder.new do
          use SearchEngineReferer::Middleware
          run lambda{|env| [200, {:referer => env['search_engine_referer']}, ['OK']]}
        end
      end

      it 'uses HTTP_REFERER by ' do
        get '/', {}, 'HTTP_REFERER' => 'http://google.com?q=test'
        last_response[:referer].should be
        last_response[:referer].search_engine.should == :google
      end
    end
  end
end
