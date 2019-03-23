class Request < ApplicationRecord
  belongs_to :user

  validates :title, presence: { message: "must be given please" }
end
