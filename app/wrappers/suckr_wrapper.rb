class SuckrWrapper

require "image_suckr"

	def google_image_url_for_phrase(phrase)
		suckr = ImageSuckr::GoogleSuckr.new
		suckr.get_image_url({"q" => "#{phrase}"})
	end

end