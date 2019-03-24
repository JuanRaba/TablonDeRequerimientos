class Vote < ApplicationRecord
  belongs_to :request
  belongs_to :user

  # maybe using before_destroy to ensure request score & popularity integrity is good
  # https://guides.rubyonrails.org/active_record_callbacks.html
end
