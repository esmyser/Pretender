class User < ActiveRecord::Base
  	has_many :pretendees
    has_many :reports, through: :pretendees
  	has_many :topics, through: :pretendees
    # has_many :pretendee_topics, through: :pretendees, source: :topic

    validates :name, presence: true

	def self.create_with_omniauth(auth)
	  create! do |user|
	    user.provider = auth["provider"]
	    user.uid = auth["uid"]
	    user.name = auth["info"]["name"]
	  end
	end

end