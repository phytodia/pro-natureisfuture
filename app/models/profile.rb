class Profile < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :team_member, optional: true
  has_many :instituts, dependent: :destroy
end
