class Comment < ApplicationRecord
  belongs_to :request
  belongs_to :user
end
