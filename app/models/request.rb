class Request < ApplicationRecord
  belongs_to :user
  has_many :votes

  validates :title, presence: { message: "must be given please" }
end
