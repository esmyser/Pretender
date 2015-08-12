class PretendeePropertiesHydrator
	include ActiveModel::Model

	def initialize(pretendee_id)
		PretendeeWorker.perform_async(pretendee_id)
	end

end