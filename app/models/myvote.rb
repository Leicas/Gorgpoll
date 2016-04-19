class Myvote
  include ActiveModel::Model

  attr_accessor :candidate_id, :token, :clef

  validates :candidate_id, :token, :clef, presence: true
end
