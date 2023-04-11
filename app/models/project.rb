class Project < ApplicationRecord
  has_one_attached :thumbnail
  has_one_attached :banner
  has_many_attached :detail_images
  has_rich_text :content

  validates :thumbnail, presence: true
  validates :banner, presence: true
  validates :detail_images, presence: true
end
