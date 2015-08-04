require 'rails_helper'

describe Pretendee do

  describe '#valid?' do

    let(:pretendee){ Pretendee.new(twitter: handle) }
    let(:handle){ "esmyser" }

  context "when the pretendee doesn't have a twitter handle"
    # setup - environment to fire the trigger
    let(:handle){ nil }

    it 'is invalid' do

      # trigger - action to create the desired action
      # & expectation - what we expect to happen
      expect(pretendee).to_not be_valid
      
      # teardown - rails does this for you, removes everything you created
    end
  end
end