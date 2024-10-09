class PhotothequeEspacePro < ApplicationRecord
  has_many_attached :files
  has_many :phototheque_espace_pro_folders
end
