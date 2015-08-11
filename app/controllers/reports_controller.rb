class ReportsController < ApplicationController

  def create
    @report = Report.new(report_params)
    @user = current_user

    if report_params['pretendee_id']
      @pretendee = Pretendee.find(report_params['pretendee_id'])
    else
      @topic = Topic.find(report_params['topic_id'])
    end

    if @pretendee && @report.save
      respond_to do |format|
        format.html {redirect_to user_pretendee_path(@user, @pretendee)}
        format.js
      end
    elsif @topic && @report.save
      respond_to do |format|
        format.html {redirect_to user_topic_path(current_user, @topic)}
        format.js
      end
    end
  end

  def update
    @report = Report.find(params['id'])
    @pretendee = @report.pretendee
    @topic = @report.topic
    @report.update(report_params)
    @user = current_user

    if @pretendee
      respond_to do |format|
        format.html {redirect_to user_pretendee_path(@user, @pretendee)}
        format.js
      end
    else
      respond_to do |format|
        format.html {redirect_to user_topic_path(current_user, @topic)}
        format.js
      end
    end
  end

  private
    def report_params
      params.require(:report).permit(:frequency, :pretendee_id, :active, :topic_id)
    end

end
