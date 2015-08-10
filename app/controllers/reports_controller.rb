class ReportsController < ApplicationController

  def create
    @report = Report.new(report_params)
    
    if report_params['pretendee_id']
      @pretendee = Pretendee.find(report_params['pretendee_id'])
    else
      @topic = Topic.find(report_params['topic_id'])
    end

    if @pretendee
      if @report.save 
        redirect_to user_pretendee_path(current_user, @pretendee)
      else
        flash.now[:notice] = @report.errors.full_messages.to_sentence
        render :back
      end
    else
      if @report.save 
        redirect_to user_topic_path(current_user, @topic)
      else
        flash.now[:notice] = @report.errors.full_messages.to_sentence
        render :back
      end
    end

  end

  def update
    binding.pry
    @report = Report.find(params['id'])
    @pretendee = @report.pretendee
    @topic = @report.topic
    @report.update(report_params)
    if @pretendee 
      redirect_to user_pretendee_path(current_user, @pretendee)
    else
      redirect_to user_topic_path(current_user, @topic)
    end
  end

  private
    def report_params
      params.require(:report).permit(:frequency, :pretendee_id, :active, :topic_id)
    end

end
