require 'spec_helper'

describe SearchEngineReferer::Mailru do
  let(:parser){described_class}
  describe '#search_engine' do
    it 'should be mailru' do
      parser.new('http://go.mail.ru').search_engine.should == :mailru
    end
  end

  describe '#page' do
    it 'should parse page if it specified in query' do
      parser.new('http://go.mail.ru?rch=l&sf=0').page.should == 1
      parser.new('http://go.mail.ru?rch=l&sf=10').page.should == 2
    end

    it 'should parse page if it not specified in query' do
      parser.new('http://go.mail.ru').page.should == 1
    end
  end

  describe '#query' do
    it 'should parse user query correctly from text parameter' do
      parser.new(URI.escape('http://go.mail.ru?q=test+user+request')).query.
        should == 'test user request'
    end

    it 'should parse user query with unicode symbols' do
      parser.new(URI.escape('http://go.mail.ru?q=тестовый+запрос')).query.
        should == 'тестовый запрос'
    end
  end
end
