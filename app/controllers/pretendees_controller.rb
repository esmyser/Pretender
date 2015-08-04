class PretendeesController < ApplicationController
	def new
		@pretendee = Pretendee.new
	end

	def create
		render nothing :true
	end

	def edit
		@pretendee = Pretendee.find(params[:id])
	end

	def update
		render nothing: true
	end
end
