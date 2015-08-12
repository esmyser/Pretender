class ReportsController < ApplicationController

  def create
    @report = Report.new(report_params)
    @user = current_user
    if @report.save && report_params['pretendee_id']
      @pretendee = Pretendee.find(report_params['pretendee_id'])
      respond_to do |format|
        format.html {redirect_to user_pretendee_path(@user, @pretendee)}
        format.js
      end
    elsif @report.save && report_params['topic_id']
      @topic = Topic.find(report_params['topic_id'])
      respond_to do |format|
        format.html {redirect_to user_topic_path(@user, @topic)}
        format.js
      end
    end
  end

  def update
    binding.pry
    @report = Report.find(params['id'])
    @report.update(report_params)
    @user = current_user
    if @report.save && report_params['pretendee_id']
      respond_to do |format|
        format.html {redirect_to user_pretendee_path(@user, @pretendee)}
        format.js
      end
    elsif @report.save && report_params['topic_id']
      binding.pry
      respond_to do |format|
        format.html {redirect_to user_topic_path(@user, @topic)}
        format.js
      end
    end
  end

  private
    def report_params
      params.require(:report).permit(:frequency, :pretendee_id, :active, :topic_id)
    end

end
