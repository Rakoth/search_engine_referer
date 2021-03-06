require 'spec_helper'

describe SearchEngineReferer::Base do
  describe '.factory' do
    it 'should build correct parser with factory' do
      SearchEngineReferer::Base.factory('http://google.com').
        should be_an_instance_of(SearchEngineReferer::Google)
    end

    it 'should build correct parser for yandex referer' do
      SearchEngineReferer::Base.factory('http://yandex.ru').
        should be_an_instance_of(SearchEngineReferer::Yandex)
    end

    it 'should build correct parser for mailru referer' do
      SearchEngineReferer::Base.factory('http://go.mail.ru').
        should be_an_instance_of(SearchEngineReferer::Mailru)
    end

    it 'should build correct parser for rambler referer' do
      SearchEngineReferer::Base.factory('http://nova.rambler.ru').
        should be_an_instance_of(SearchEngineReferer::Rambler)
    end

    it 'should build correct parser for rambler referer' do
      SearchEngineReferer::Base.factory('http://bing.com').
        should be_an_instance_of(SearchEngineReferer::Bing)
    end

    it 'should return nil if referer cannot be parsed' do
      SearchEngineReferer::Base.factory('http://test.ru').should be_nil
    end

    it 'should return nil if referer cannot be parsed (goggle in host name)' do
      SearchEngineReferer::Base.factory('http://avia.newgoogle.ru').should be_nil
    end
  end

  describe '#to_hash' do
    it 'should provide all parsed params as hash' do
      SearchEngineReferer::Yandex.new('http://yandex.ru?text=test&p=1').to_hash.should == {
        :source => 'http://yandex.ru?text=test&p=1',
        :page => 2,
        :query => 'test',
        :search_engine => :yandex
      }
    end
  end
end
