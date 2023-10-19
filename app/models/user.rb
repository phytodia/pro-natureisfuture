class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_one :profile, dependent: :destroy
  has_one :team_member, dependent: :destroy
  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :team_member

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
