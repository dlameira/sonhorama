class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update]

  def index
    @projects = Project.all
  end

  def show
    raise
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params.except(:detail_images_row_1, :detail_images_row_2, :detail_images_row_3, :detail_images_row_4, :detail_images_row_5, :detail_images_row_6, :detail_images_row_7, :detail_images_row_8, :detail_images_row_9, :detail_images_row_10))

    (1..10).each do |row_number|
      row_images_param = "detail_images_row_#{row_number}".to_sym
      project_params[row_images_param].each do |image|
        if image.present?
          @project.detail_images.attach(io: image.tempfile, filename: image.original_filename, content_type: image.content_type, metadata: { row: row_number })
        end
      end
    end

    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @project
  end

  def update
    @project.assign_attributes(project_params.except(:detail_images_row_1, :detail_images_row_2, :detail_images_row_3, :detail_images_row_4, :detail_images_row_5, :detail_images_row_6, :detail_images_row_7, :detail_images_row_8, :detail_images_row_9, :detail_images_row_10))

    (1..10).each do |row_number|
      row_images_param = "detail_images_row_#{row_number}".to_sym
      existing_images = @project.detail_images.includes(:blob).where("metadata ->> 'row' = ?", row_number.to_s)

      # Remove existing images for the current row
      if project_params[row_images_param].nil?
        existing_images.each do |image|
          @project.detail_images.destroy(image)
        end
      else
        # Add new images for the current row
        project_params[row_images_param].each do |image|
          if image.present?
            @project.detail_images.attach(io: image.tempfile, filename: image.original_filename, content_type: image.content_type, metadata: { row: row_number })
          end
        end
        # Remove the images that are no longer included in the params
        (existing_images - @project.detail_images.where("metadata ->> 'row' = ?", row_number.to_s)).each do |image|
          @project.detail_images.destroy(image)
        end
      end
    end

    if @project.save
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :subheading, :description, :callout, :collaborators, :client, :date, :thumbnail, :banner, :content,
                                      detail_images_row_1: [], detail_images_row_2: [], detail_images_row_3: [],
                                      detail_images_row_4: [], detail_images_row_5: [], detail_images_row_6: [],
                                      detail_images_row_7: [], detail_images_row_8: [], detail_images_row_9: [],
                                      detail_images_row_10: [])
  end
end
