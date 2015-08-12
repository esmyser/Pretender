class SuckrWrapper

# require "image_suckr"

	# def initialize(topic)
	# 	@topic = topic
 #  end

	def google_image_url_for_phrase(topic)
		suckr = ImageSuckr::GoogleSuckr.new
		suckr.get_image_url({"q" => "#{topic}"})
	end

end