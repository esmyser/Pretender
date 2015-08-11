require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  describe '#show' do 
    before do 
      get :show
    end
    
    context 'when articles are empty' do 
      it 'assigns nytimes articles' do
        expect(NyTimesWrapper).to_receive(:articles).and_return({})
        expect(@topic.articles).to eq {}
      end
    end

    context 'when articles exist' do 
      it 'assigns nytimes articles' do
        expect(NyTimes).to_not receive(:get_articles)
        expect(@topic.articles).to eq {}
      end
    end

    it 'assigns tweets' do 
      expect(@topic.tweets).to_not be_empty
    end

    it 'assigns wiki text' do 
      expect(@topic.wiki_text).to_not be_empty
    end
  end
end
