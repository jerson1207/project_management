class CategoriesController < ApplicationController
  before_action :set_category, only: %i[     show edit update destroy]
  before_action :set_project, only: %i[show edit update destroy]
  
  # GET /categories or /categories.json
  def index
    @project = Project.find(params[:project_id])
    @categories = @project.categories.all
  end

  # GET /categories/1 or /categories/1.json
  def show    
  end

  # GET /categories/new
  def new
    @project = current_user.projects.find(params[:project_id])
    @category = @project.categories.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    # @project = current_user.projects.find(params[:project_id]) 
    # @category = @project.categories.new(category_params)
    @project = Project.find(params[:project_id])
    @category = current_user.projects.find(params[:project_id]).categories.new(category_params)
    respond_to do |format|
      if @category.save
        if @category.deadline.present? 
          Category.update_deadline(@project.id, @category.deadline)
        end
        Category.update_progress(@project.id)

        format.html { redirect_to project_category_tasks_path(@project.id, @category.id), notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    @project = Project.find(params[:project_id])
    @category = @project.categories.find(params[:id])
    respond_to do |format|
      if @category.update(category_params)
        if @category.deadline.present? 
          Category.update_deadline(@project.id, @category.deadline)
        end
        format.html { redirect_to project_categories_path, notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy 
    redirect_to project_categories_path, notice: "Task was successfully destroyed." 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_category
      @category = Project.find(params[:project_id]).categories.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :complete, :timelimit, :deadline, :project_id)
    end
end
