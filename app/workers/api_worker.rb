class ApiWorker
	include Sidekiq::Worker

	def perform(pretendee_id)

		pretendee = Pretendeee.find(params['id'])
		
		pretendee.update(name: TwitterWrapper.new(pretendee).get_name)
    redirect_to user_pretendee_path(current_user, pretendee)
	end

end
