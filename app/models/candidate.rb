class Candidate < ActiveRecord::Base
  belongs_to :user
  belongs_to :poll
end
