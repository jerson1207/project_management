class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :set_project, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @project = Project.find(params[:project_id])
    @category = @project.categories.find(params[:category_id])
    @tasks = @category.tasks.all
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @project = Project.find(params[:project_id])
    @category = Project.find(params[:project_id]).categories.find(params[:category_id])
    @task = @category.tasks.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @project = Project.find(params[:project_id])
    @category = Project.find(params[:project_id]).categories.find(params[:category_id])
    @task = current_user.projects.find(params[:project_id]).categories.find(params[:category_id]).tasks.new(task_params)
    respond_to do |format|
      if @task.save
        Task.update_progress(@project.id, @category.id)
        if @task.deadline.present?
          Task.update_deadline(@project.id, @category.id, @task.deadline)
        end
        format.html { redirect_to project_category_tasks_path, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        Task.update_progress(@project.id, @category.id)
        if @task.deadline.present?
          Task.update_deadline(@project.id, @category.id, @task.deadline)
        end
        format.html { redirect_to project_category_tasks_path, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_category_tasks_path, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Project.find(params[:project_id]).categories.find(params[:category_id]).tasks.find(params[:id])
    end

    def set_category
      @category = Project.find(params[:project_id]).categories.find(params[:category_id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :complete, :timelimit, :deadline, :category_id)
    end
end
