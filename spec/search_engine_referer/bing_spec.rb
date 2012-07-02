require 'spec_helper'

describe SearchEngineReferer::Bing do
  let(:parser){SearchEngineReferer::Bing}
  describe '#search_engine' do
    it 'should be google' do
      parser.new('http://bing.com').search_engine.should == :bing
    end
  end

  describe '#page' do
    it 'should parse page if it specified in query' do
      parser.new('http://bing.com?first=1').page.should == 1
      parser.new('http://bing.com?first=11').page.should == 2
    end

    it 'should parse page if it not specified in query' do
      parser.new('http://bing.com').page.should == 1
    end
  end

  describe '#query' do
    it 'should parse user query correctly from text parameter' do
      parser.new(URI.escape('http://bing.com?q=test+user+request')).query.
        should == 'test user request'
    end

    it 'should parse user query with unicode symbols' do
      parser.new(URI.escape('http://bing.com?q=тестовый+запрос')).query.
        should == 'тестовый запрос'
    end
  end
end
