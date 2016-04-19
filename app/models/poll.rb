class Poll < ActiveRecord::Base
  has_many :candidates
  has_many :votes
  belongs_to :user
end
