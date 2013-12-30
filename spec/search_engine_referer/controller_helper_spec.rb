require 'spec_helper'
require 'search_engine_referer/controller_helper'

class Controller
  def initialize request
    @request = request
  end

  def self.helpers
    @helpers ||= []
  end

  def self.helper_method *args
    helpers.push(*args)
  end

  def env
    @env ||= {}
  end

  attr_accessor :request

  include SearchEngineReferer::ControllerHelper
end

describe SearchEngineReferer::ControllerHelper do
  it 'should add helpers to controller when included' do
    Controller.helpers.should =~ [:search_engine_query, :search_engine_referer]
  end

  describe 'search engine helpers' do
    subject{Controller.new(request)}
    let(:referer_source){'http://yandex.ru?text=test'}
    let(:referer){SearchEngineReferer::Yandex.new(referer_source)}

    context 'referer given in headers' do
      let(:request){double(referer: referer_source)}
      its(:search_engine_query){should == 'test'}
      its(:search_engine_referer){should == referer}
    end

    context 'with search engine referer middleware' do
      before do
        subject.env['search_engine_referer'] = referer
      end

      let(:request){double(referer: nil)}
      its(:search_engine_query){should == 'test'}
      its(:search_engine_referer){should == referer}
    end
  end
end
