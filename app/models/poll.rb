class Poll < ActiveRecord::Base
  has_many :candidates
end
