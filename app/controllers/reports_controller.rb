class ReportsController < ApplicationController

  def create
    @report = Report.new(report_params)
    @user = current_user
    @pretendee = Pretendee.find(report_params['pretendee_id'])
    if @report.save 
      @pretendee.report = true
      @pretendee.save
      redirect_to user_pretendee_path(current_user, @pretendee)
    else
      render :new
    end
  end

  private
    def report_params
      params.require(:report).permit(:frequency, :pretendee_id)
    end

end
