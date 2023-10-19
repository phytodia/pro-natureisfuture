class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :team_member, optional: true
end
