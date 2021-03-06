class InstagramWrapper

  require "instagram"

  def initialize
    Instagram.configure do |config|
      config.client_id = ENV['instagram_id']
      config.access_token = ENV['instagram_access_token']
    end
  end

  def public_instagram?(photo_id)
    begin 
      Instagram.client.media_shortcode(photo_id)
    rescue
      false
    else
      true
    end
  end

  def get_id(photo_id)
    if photo_id 
      begin
        photo = Instagram.client.media_shortcode(photo_id)
        photo[:user][:id]
      rescue
        # do nothing
      end
    end
  end
  
  def recent_instgrams(insta_user_id)
    insta_user_id = insta_user_id.to_i
    pics = Instagram.user_recent_media(insta_user_id, {:count => 6})
    pics.map do |pic|
      {
        url: pic.link,
        caption: pic.caption && pic.caption.text,
        photo_url: pic.images.standard_resolution.url,
        date: Time.at(pic.created_time.to_i)
      }
    end.compact
  end

  def instagram_caption_text(insta_user_id)
    initial_page = Instagram.user_recent_media(insta_user_id)
    insta_user_id = insta_user_id.to_i
    photos = []
    parse_pages_starting_with(initial_page, insta_user_id, photos)
  end

  def parse_pages_starting_with(page, insta_user_id, photos)
    unless page.pagination.next_max_id.nil?
      photos << page.collect {|i| i.caption}.compact
      next_page = Instagram.user_recent_media(insta_user_id, :max_id => page.pagination.next_max_id )
      parse_pages_starting_with(next_page, insta_user_id, photos)
    end
    photos.flatten.collect {|c| c.text}.compact
  end

  def insta_username(insta_user_id)
    Instagram.user(insta_user_id)[:username]
  end

  def instagram_tag_search
    client = Instagram.client(:access_token => ENV['instagram_access_token'])
    tags = client.tag_search('basketball')
    client.tag_recent_media(tags[0].name).first[:images][:standard_resolution][:url]
  end

  # get "/tags" do
  #   client = Instagram.client(:access_token => session[:access_token])
  #   html = "<h1>Search for tags, get tag info and get media by tag</h1>"
  #   tags = client.tag_search('cat')
  #   html << "<h2>Tag Name = #{tags[0].name}. Media Count =  #{tags[0].media_count}. </h2><br/><br/>"
  #   for media_item in client.tag_recent_media(tags[0].name)
  #     html << "<img src='#{media_item.images.thumbnail.url}'>"
  #   end
  #   html
  # end

end