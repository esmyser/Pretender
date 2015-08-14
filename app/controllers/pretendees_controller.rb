class PretendeesController < ApplicationController
  
  def new
    @user = current_user
  end

  def create
    @user = current_user
    @pretendee = Pretendee.new(pretendee_params)
    @pretendee.image = "https://twitter.com/" + @pretendee.twitter.gsub(' ', '') + "/profile_image?size=original"
    @pretendee.save
    PretendeePropertiesHydrator.new(@pretendee.id)

    respond_to do |format|
      format.html { topic.save ? (redirect_to user_path(current_user)) : (render :new) }
      format.js { }
    end
  end

  def show
    @pretendee = Pretendee.find(params['id'])
    @topic = Topic.new
    @user = current_user
    @report = @pretendee.report || Report.new
  end

  def update
    @pretendee = Pretendee.find(params['id'])
    @pretendee.update(pretendee_params)
    redirect_to user_pretendee_path(current_user, @pretendee)
  end

  def destroy
    @pretendee = Pretendee.find(params['id'])
    @pretendee.destroy
    redirect_to user_path(User.find(params['user_id']))
  end

  private
    def pretendee_params
      params.require(:pretendee).permit(:twitter, :user_id, :name)
    end
end