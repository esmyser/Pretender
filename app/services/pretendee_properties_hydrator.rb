class PretendeePropertiesHydrator
	include ActiveModel::Model

	# attr_accessor :tweets, :word_histogram, :instagram_photos

	def initialize(pretendee_id)
		PretendeeWorker.perform_async(pretendee_id)
	end

end