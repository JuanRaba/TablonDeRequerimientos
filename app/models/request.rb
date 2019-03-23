class Request < ApplicationRecord
  belongs_to :user
  has_many :votes

  validates :title, presence: { message: "must be given please" }

   def vote_result
    self.votes.pluck("value").sum()
  end
end
