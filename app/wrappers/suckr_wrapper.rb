class SuckrWrapper

	def google_image_url_for_phrase(topic)
		suckr = ImageSuckr::GoogleSuckr.new
		suckr.get_image_url({"q" => "#{topic}"})
	end
end