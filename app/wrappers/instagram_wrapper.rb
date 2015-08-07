class InstagramWrapper

require "instagram"

	def initialize
		Instagram.configure do |config|
		  config.client_id = ENV['instagram_id']
		  config.access_token = ENV['instagram_access_token']
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

end