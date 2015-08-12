class NyTimesWrapper

  def articles(topic)
    separated_name = topic.name.gsub(" ", "%20")
    date = (Time.now - 30.days).to_s.split.first.split("-").join("")
      articles = open("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{separated_name}&additional-params=multimedia&begin_date=#{date}&api-key=#{ENV["ny_times_key"]}").read
      parse_article_hash(JSON.parse(articles))
  end

  def parse_article_hash(art_hash)
    art_hash['response']['docs'][0..4].map do |art|
      if art['multimedia'].empty?
        keywords = art['snippet']
        url = SuckrWrapper.new.google_image_url_for_phrase(keywords)
      else
        url ="http://nytimes.com/#{art['multimedia'].max_by{|hash| hash['width']}['url']}"
      end
      {
        url: art['web_url'],
        title: art['headline']['main'],
        photo_url: url,
        snippet: art['snippet'],
        date: art['pub_date'].split("T").first
      }
    end.compact
  end
end