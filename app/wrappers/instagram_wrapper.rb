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
    photo = Instagram.client.media_shortcode(photo_id)
    photo[:user][:id]
  end

	def five_instagrams(insta_user_id)
    insta_user_id = insta_user_id.to_i
		Instagram.user_recent_media(insta_user_id, {:count => 10})
	end

  def update_user_instagram(pretendee, insta_user_id)
    pretendee.update(instagram: Instagram.user(insta_user_id)[:username])
  end

end