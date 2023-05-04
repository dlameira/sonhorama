module ApplicationHelper
  def detail_images_by_row(project, row_number)
    project.detail_images.filter { |image| image.metadata['row'] == row_number }
  end
end
