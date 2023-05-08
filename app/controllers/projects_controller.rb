class ProjectsController < ApplicationController
  include ApplicationHelper
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def destroy
    @project.destroy
    redirect_to projects_path, status: :see_other
  end

  def index
    @projects = Project.all.order(:position)
  end

  def show

  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params.except(:detail_images_row_1, :detail_images_row_2, :detail_images_row_3, :detail_images_row_4, :detail_images_row_5, :detail_images_row_6, :detail_images_row_7, :detail_images_row_8, :detail_images_row_9, :detail_images_row_10, :detail_images_row_11, :detail_images_row_12, :detail_images_row_13, :detail_images_row_14, :detail_images_row_15))

    (1..15).each do |row_number|
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

  def update_order
    params[:order].each_with_index do |id, index|
      Project.find(id).update(position: index + 1)
    end

    head :ok
  end

  def update_position
    @item = Project.find(params[:id])
    new_position = JSON.parse(request.body.read)["position"]
    @item.update(position: new_position)
    head :ok
  end

  def update
    # Handle detail images update
    (1..15).each do |row_number|
      row_images_param = "detail_images_row_#{row_number}".to_sym
      new_images = project_params[row_images_param]
      existing_images = detail_images_by_row(@project, row_number)

      if new_images.present?
        existing_images.each_with_index do |existing_image, index|
          if new_images[index].present?
            existing_image.purge_later
          end
        end

        # Attach new images for the current row
        new_images.each do |image|
          if image.present?
            @project.detail_images.attach(io: image.tempfile, filename: image.original_filename, content_type: image.content_type, metadata: { row: row_number })
          end
        end
      end
    end

    if @project.update(project_params.except(:detail_images_row_1, :detail_images_row_2, :detail_images_row_3, :detail_images_row_4, :detail_images_row_5, :detail_images_row_6, :detail_images_row_7, :detail_images_row_8, :detail_images_row_9, :detail_images_row_10, :detail_images_row_11, :detail_images_row_12, :detail_images_row_13, :detail_images_row_14, :detail_images_row_15))
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private

  def update_detail_images
    (1..15).each do |row_number|
      row_images_param = "detail_images_row_#{row_number}".to_sym
      new_images = project_params[row_images_param]
      existing_images = detail_images_by_row(@project, row_number)

      if new_images.present?
        # Destroy existing images for the current row
        existing_images.each(&:destroy)

        # Attach new images for the current row
        new_images.each do |image|
          if image.present?
            @project.detail_images.attach(io: image.tempfile, filename: image.original_filename, content_type: image.content_type, metadata: { row: row_number })
          end
        end
      end
    end
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :subheading, :description, :credit, :callout, :collaborators, :client, :date, :thumbnail, :banner, :content, :listed, :position,
                                      detail_images_row_1: [], detail_images_row_2: [], detail_images_row_3: [],
                                      detail_images_row_4: [], detail_images_row_5: [], detail_images_row_6: [],
                                      detail_images_row_7: [], detail_images_row_8: [], detail_images_row_9: [],
                                      detail_images_row_10: [], detail_images_row_11: [], detail_images_row_12: [],
                                      detail_images_row_13: [], detail_images_row_14: [], detail_images_row_15: [])
  end
end
