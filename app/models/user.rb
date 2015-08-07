class User < ActiveRecord::Base
  	has_many :pretendees
  	has_many :topics
    has_many :reports, through: :pretendees
    has_many :pretendee_topics, through: :pretendees, source: :topics

    validates :name, presence: true
    validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

	def self.create_with_omniauth(auth)
	  create! do |user|
	    user.provider = auth["provider"]
	    user.uid = auth["uid"]
	    user.name = auth["info"]["name"]
	  end
	end

end