class BlogPost < ApplicationRecord
  has_rich_text :chapo
  has_rich_text :content
  has_one_attached :photo

  extend FriendlyId
  friendly_id :titre, use: :slugged
end
