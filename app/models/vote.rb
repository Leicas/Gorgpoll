class Vote < ActiveRecord::Base
  belongs_to :poll
  attr_accessor :hruid
	def generate_token
		self.token = loop do
			random_token = SecureRandom.urlsafe_base64(nil, false)
			break random_token unless Vote.exists?(token: random_token)
		end
                self.clef = Digest::SHA1.hexdigest (self.hruid + self.poll_id.to_s)
	end
        def used?
		self.used
	end
        def set_used
		self.used = true
		self.save
	end
        def usable?
		if !self.used? && self.poll.datestart <= Time.now && self.poll.datefinish >= Time.now
			return true
		else
			return false
		end
	end
end
