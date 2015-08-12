class ReportsController < ApplicationController

  def create
    @report = Report.new(report_params)
    @user = current_user
    if report_params['pretendee_id']
      @pretendee = Pretendee.find(report_params['pretendee_id'])
      if @report.save
        respond_to do |format|
          format.html {redirect_to user_pretendee_path(@user, @pretendee)}
          format.js
        end
      end
    elsif report_params['topic_id']
      @topic = Topic.find(report_params['topic_id'])
      if @report.save 
        respond_to do |format|
          format.html {redirect_to user_topic_path(@user, @topic)}
          format.js
        end
      end
    end
  end

  def update
    @report = Report.find(params['id'])
    @report.update(report_params)
    @user = current_user
    if report_params['pretendee_id']
      @pretendee = Pretendee.find(report_params['pretendee_id'])
      if @report.save 
        respond_to do |format|
          format.html {redirect_to user_pretendee_path(@user, @pretendee)}
          format.js
        end
      end
    elsif report_params['topic_id']
      @topic = Topic.find(report_params['topic_id'])
      if @report.save 
        respond_to do |format|
          format.html {redirect_to user_topic_path(@user, @topic)}
          format.js
        end
      end
    end
  end

  private
    def report_params
      params.require(:report).permit(:frequency, :pretendee_id, :active, :topic_id)
    end

end
