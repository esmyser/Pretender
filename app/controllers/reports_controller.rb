class ReportsController < ApplicationController

  def create
    @report = Report.new(report_params)
    @user = current_user
    @pretendee = Pretendee.find(report_params['pretendee_id'])
    if @report.save 
      redirect_to user_pretendee_path(current_user, @pretendee)
    else
      flash.now[:notice] = @report.errors.full_messages.to_sentence
      render :back
    end
  end

  def update
    @report = Report.find(params['id'])
    @pretendee = @report.pretendee
    @report.update(report_params)
    redirect_to user_pretendee_path(current_user, @pretendee)
  end

  private
    def report_params
      params.require(:report).permit(:frequency, :pretendee_id, :active)
    end

end
