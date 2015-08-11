class Topic < ActiveRecord::Base
  belongs_to :pretendee
  belongs_to :user
  has_one :report
  
  def get_ny_times_articles
    articles = NyTimesWrapper.new.articles(self)
    update(ny_times_articles: articles)
    ny_times_articles
  end

  def get_wiki_text
    wiki_paragraph = WikiWrapper.new.wiki_text(self)
    update(wiki_text: wiki_paragraph)
    wiki_text
  end

  def get_tweets
    pop_tweets = TwitterWrapper.new(Pretendee.new).popular_tweets(self)
    update(tweets: pop_tweets)
    tweets
  end
end
