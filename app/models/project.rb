class Project < ApplicationRecord
  has_one_attached :thumbnail, dependent: :destroy
  has_one_attached :banner, dependent: :destroy
  has_many_attached :detail_images, dependent: :destroy
  has_many :project_tags, dependent: :destroy
  has_rich_text :content
  has_rich_text :credit

  validates :thumbnail, presence: true
  validates :banner, presence: true
  validates :detail_images, presence: true

  default_scope { order(:position) }
end
