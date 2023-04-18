class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update]

  def index
    @projects = Project.all
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

  def update
    # @project.assign_attributes(project_params.except(:detail_images_row_1, :detail_images_row_2, :detail_images_row_3, :detail_images_row_4, :detail_images_row_5, :detail_images_row_6, :detail_images_row_7, :detail_images_row_8, :detail_images_row_9, :detail_images_row_10, :detail_images_row_11, :detail_images_row_12, :detail_images_row_13, :detail_images_row_14, :detail_images_row_15))

    #   (1..15).each do |row_number|
    #   row_images_param = "detail_images_row_#{row_number}".to_sym
    #   row_images = @project.detail_images.first(row_number)

    #   if project_params[row_images_param].nil?
    #     # Remove existing images for the current row
    #     row_images.purge
    #   else
    #     # Remove existing images for the current row
    #     row_images.each(&:purge)

    #     # Add new images for the current row
    #     project_params[row_images_param].each do |image|
    #       if image.present?
    #         @project.detail_images.attach(io: image.tempfile, filename: image.original_filename, content_type: image.content_type, metadata: { row: row_number })
    #       end
    #     end
    #   end

    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end

    # if @project.save
    #   redirect_to @project, notice: 'Project was successfully updated.'
    # else
    #   render :edit, status: :unprocessable_entity
    # end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :subheading, :description, :credit, :callout, :collaborators, :client, :date, :thumbnail, :banner, :content, :listed,
                                      detail_images_row_1: [], detail_images_row_2: [], detail_images_row_3: [],
                                      detail_images_row_4: [], detail_images_row_5: [], detail_images_row_6: [],
                                      detail_images_row_7: [], detail_images_row_8: [], detail_images_row_9: [],
                                      detail_images_row_10: [], detail_images_row_11: [], detail_images_row_12: [],
                                      detail_images_row_13: [], detail_images_row_14: [], detail_images_row_15: [],)
  end
end
