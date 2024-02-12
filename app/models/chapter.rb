class Chapter < ApplicationRecord
  has_rich_text :content
  belongs_to :course
end
