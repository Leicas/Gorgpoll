class Vote < ActiveRecord::Base
  belongs_to :poll
	def generate_token
		self.token = loop do
			random_token = SecureRandom.urlsafe_base64(nil, false)
			break random_token unless Vote.exists?(token: random_token)
		end
                self.clef = SecureRandom.hex(4)
	end
        def used?
		self.used
	end
        def set_used
		self.used = true
		self.save
	end
        def usable?
		if !self.used?
			return true
		else
			return false
		end
	end
end
