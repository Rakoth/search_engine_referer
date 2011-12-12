require 'spec_helper'

describe SearchEngineReferer::Rambler do
  let(:parser){SearchEngineReferer::Rambler}
  describe '#search_engine' do
    it 'should be rambler' do
      parser.new('http://nova.rambler.ru').search_engine.should == :rambler
    end
  end

  describe '#page' do
    it 'should parse page if it is not specified' do
      parser.new('http://nova.rambler.ru?query=test').page.should == 1
    end

    it 'should parse page if it is specified in url' do
      parser.new('http://nova.rambler.ru?query=test&page=2').page.should == 2
    end
  end

  describe '#query' do
    it 'should parse page if it is not specified' do
      parser.new('http://nova.rambler.ru?query=test').query.should == 'test'
    end
  end
end
