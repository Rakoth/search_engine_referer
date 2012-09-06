require 'spec_helper'

describe SearchEngineReferer do
  describe '.engines' do
    it 'should return all supported engines' do
      SearchEngineReferer.engine_names.should =~ [:yandex, :google, :rambler, :bing]
    end
  end
  
  describe '.parse' do
    it 'should return referer or nil' do
      SearchEngineReferer.parse('http://yandex.ru').
        should be_kind_of(SearchEngineReferer::Base)

      SearchEngineReferer.parse('http://test.ru').should be_nil
    end

    it 'should handle empty referer' do
      SearchEngineReferer.parse(nil).should be_nil
    end

    it 'should handle known domains only' do
      SearchEngineReferer.parse('http://test.ru?q=1&text=2').should be_nil
    end

    it 'should handle google referer' do
      SearchEngineReferer.parse('http://google.ru?q=1&text=2').query.should == '1'
    end

    it 'should handle yandex referer' do
      SearchEngineReferer.parse('http://yandex.ru?q=1&text=2').query.should == '2'
    end

    it 'should handle rambler referer' do
      SearchEngineReferer.parse('http://nova.rambler.ru?query=1&page=2').query.should == '1'
    end

    it 'should unescape params found' do
      SearchEngineReferer.parse('http://google.ru?q=1+2').query.should == '1 2'
    end

    it 'should handle urls without query params' do
      SearchEngineReferer.parse('http://google.ru').query.should == ''
    end

    it 'should return nil on incorrect referer' do
      SearchEngineReferer.parse('http://www.aviasales.ru/\\').should be_nil
    end

    it 'should return nil on incorrect referer' do
      SearchEngineReferer.parse('string with spaces').should be_nil
    end

    it 'should use iconv for cp1251 strings from yandex' do
      SearchEngineReferer.parse('http://yandex.ru/yandsearch?text=%e0%e2%e8%e0%f1%e5%eb%f1').
        query.should == 'авиаселс'
    end
  end
end
