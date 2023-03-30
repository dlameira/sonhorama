class Project < ApplicationRecord
  has_one_attached :thumbnail
  has_many_attached :detail_images
end
