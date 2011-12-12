require 'spec_helper'

describe SearchEngineReferer::Yandex do
  let(:parser){SearchEngineReferer::Yandex}
  describe '#search_engine' do
    it 'should be yandex' do
      parser.new('http://yandex.ru').search_engine.should == :yandex
    end
  end
  
  describe '#page' do
    it 'should parse page if it specified in query' do
      parser.new('http://yandex.ru?p=2').page.should == 3
    end

    it 'should parse page if it not specified in query' do
      parser.new('http://yandex.ru').page.should == 1
    end
  end

  describe '#query' do
    it 'should parse user query correctly from text parameter' do
      parser.new(URI.escape('http://yandex.ru?text=test user request')).
        query.should == 'test user request'
    end

    it 'should parse user query with unicode symbols' do
      parser.new(URI.escape('http://yandex.ru?text=тестовый запрос')).
        query.should == 'тестовый запрос'
    end
  end
end
