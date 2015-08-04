require 'rails_helper'

describe User do
  let(:user){ User.new(name: name) }
  let(:name) {"elaina"}
  describe '#valid?' do

    context "when the user doesn't have a name"
    let(:name){ nil }

    it 'is invalid' do

      expect(user).to_not be_valid
    end
  end
  
  describe '#pretendees' do
    let(:user) {User.create(name: "my name")}

    context 'when a user has a pretendee'
    let(:pretendee) { Pretendee.create(twitter: handle, user_id: user.id)}
    let(:handle) {"esmyser"}
    
    it 'the pretendee is associated with the user' do
      expect(user.pretendees).to include(pretendee)
    end
  end

  describe '#topics' do
    let(:user) {User.create(name: "my name")}
    
    context 'when a user has pretendees with topics'

    let(:pretendee) { Pretendee.create(twitter: "handle", user_id: user.id)}
    let(:topic) {Topic.create(name: "mom", pretendee_id: pretendee.id)}

    it 'should associtae the topic with the user' do

      expect(user.topics).to include(topic)
    end
  end

end
