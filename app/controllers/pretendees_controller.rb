class PretendeesController < ApplicationController

  def show
    seth = Pretendee.new(twitter: 'bgadbaw')
    t = TwitterWrapper.new(seth)
    @word_list = t.word_count_histogram
  end
end