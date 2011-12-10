require 'spec_helper'
require 'search_engine_referer/controller_helper'

class Controller
  def initialize params, request
    @params, @request = params, request
  end

  def self.helpers
    @helpers ||= []
  end

  def self.helper_method *args
    helpers.push(*args)
  end

  attr_writer :params
  attr_accessor :request

  def params
    @params ||= {}
  end

  include SearchEngineReferer::ControllerHelper
end

describe SearchEngineReferer::ControllerHelper do
  it 'should add helpers to controller when included' do
    Controller.helpers.should =~ [:search_engine_query, :search_engine_referer]
  end

  describe 'search engine helpers' do
    subject{Controller.new(params, request)}
    let(:referer_source){'http://yandex.ru?text=test'}
    let(:referer){SearchEngineReferer::Yandex.new(referer_source)}
    
    context 'referer given in params' do
      let(:params){{:search_engine_referer => referer_source}}
      let(:request){double(:referer => 'not used referer')}
      its(:search_engine_query){should == 'test'}
      its(:search_engine_referer){should == referer}
    end

    context 'referer given only in headers' do
      let(:params){{}}
      let(:request){double(:referer => referer_source)}
      its(:search_engine_query){should == 'test'}
      its(:search_engine_referer){should == referer}
    end
  end
end
