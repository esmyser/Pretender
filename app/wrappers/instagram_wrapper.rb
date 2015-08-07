class InstagramWrapper

require "instagram"

	def initialize
		Instagram.configure do |config|
		  config.client_id = ENV['instagram_id']
		  config.access_token = ENV['instagram_access_token']
		end
	end

	def five_instagrams(insta_user_id)
		@instagram = Instagram.user_recent_media(insta_user_id, {:count => 5})
	end

end