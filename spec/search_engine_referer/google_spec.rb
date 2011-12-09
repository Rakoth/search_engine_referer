require 'spec_helper'

describe SearchEngineReferer::Google do
  let(:parser){SearchEngineReferer::Google}
  describe '#page' do
    it 'should parse page if it specified in query' do
      parser.new('http://google.ru?start=10').page.should == 2
    end

    it 'should parse page with custom results on page user setting' do
      parser.new('http://google.com?start=200&num=100').page.should == 3
    end

    it 'should parse page if it not specified in query' do
      parser.new('http://google.ru').page.should == 1
    end
  end

  describe '#query' do
    it 'should parse user query correctly from text parameter' do
      parser.new(URI.escape('http://google.ru?q=test user request')).query.
        should == 'test user request'
    end

    it 'should parse user query with unicode symbols' do
      parser.new(URI.escape('http://google.ru?q=тестовый запрос')).query.
        should == 'тестовый запрос'
    end
  end
end
