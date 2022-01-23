class Request < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 50 }
  #validates :exp_date > DateTime.current.in_time_zone('EST')
end
