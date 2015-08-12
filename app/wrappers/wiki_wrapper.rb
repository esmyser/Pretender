class WikiWrapper 
  require 'wikipedia'

  def initialize  
    Wikipedia.Configure {
      domain 'en.wikipedia.org'
      path   'w/api.php'
    }
  end

  def get_page(topic)
    topic.name = topic.name.split(" ").collect {|word| word.capitalize}.join(' ')
    page = Wikipedia.find(topic.name)
    if page.raw_data['query']['pages'].keys[0] == '-1'
      return "error"
    else
      page
    end
  end

  def first_paragraph(topic)
    if get_page(topic) == "error"
      return "Did you spell something wrong? There are no Wikipedia pages on this topic."
    else
      get_page(topic).text.split(/\r?\n/).first
    end
  end

  def get_url(topic)    
    if get_page(topic) == "error"
      return "Did you spell something wrong? There are no Wikipedia pages on this topic."
    else
      get_page(topic).fullurl
    end
  end

  def wiki_text(topic)
    {
      text: first_paragraph(topic),
      url: get_url(topic)
    }
  end

end