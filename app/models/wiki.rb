class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  validates :user, presence: true
end
