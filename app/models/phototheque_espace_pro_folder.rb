class PhotothequeEspaceProFolder < ApplicationRecord
  belongs_to :phototheque_espace_pro
  has_many_attached :files
end
