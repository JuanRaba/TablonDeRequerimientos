class Request < ApplicationRecord
  belongs_to :user
  has_many :votes
  has_many :comments

  validates :title, presence: { message: "must be given please" }

  def vote_result
    # legacy, just if want to check integrity with self.score use this timeconsuming operation 
    self.votes.pluck("value").sum()
  end
end
