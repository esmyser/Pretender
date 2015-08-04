class PretendeesController < ApplicationController

  def show
    seth = Pretendee.new(twitter: 'suomiseth')
    t = TwitterWrapper.new(seth)
    @word_list = t.word_count_histogram
  end
end