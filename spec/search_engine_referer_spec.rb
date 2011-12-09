require 'spec_helper'

describe SearchEngineReferer do
  describe '.parse' do
    it 'should return referer or nil' do
      SearchEngineReferer.parse('http://yandex.ru').
        should be_kind_of(SearchEngineReferer::Base)

      SearchEngineReferer.parse('http://test.ru').should be_nil
    end
  end
end
