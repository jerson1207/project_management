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
    @category = @project.categories.find(params[:category_id])
    @task = @category.tasks.new(task_params)
    category_deadline = Task.task_deadline(params[:category_id])
    project_deadline = Category.project_deadline(params[:project_id])
    if @task.deadline.present? && category_deadline != nil   
      if (category_deadline < @task.deadline) && (project_deadline < @task.deadline) 
        @project.deadline = @task.deadline
        @project.save
      elsif category_deadline < @task.deadline 
        @category.deadline = @task.deadline
        @category.save
      end
    elsif @task.deadline.present? && category_deadline == nil &&  project_deadline == nil
      @category.deadline = @task.deadline
      @category.save
      @project.deadline = @task.deadline
      @project.save
    elsif @task.deadline.present? && category_deadline == nil &&  project_deadline != nil
      if project_deadline < @task.deadline 
        @category.deadline = @task.deadline
        @category.save
        @project.deadline = @task.deadline
        @project.save
      end
    end
    respond_to do |format|
      if @task.save
        task_complete = @category.tasks.where(complete: true).count.to_f
        task_total = @category.tasks.all.count.to_f  
        category_result = task_complete/task_total
        @category.progress = (category_result * 100)
        @category.save
        if @category.progress == 100
          @category.complete = true 
          @category.save    
        else
          @category.complete = false 
          @category.save
        end
        cat_complete = @project.categories.where(complete: true).count.to_f
        cat_total = @project.categories.all.count.to_f
        project_result = cat_complete/cat_total
        @project.progress = (project_result * 100)
        @project.save
        if @project.progress == 100
          @project.complete = true
          @project.save
        else
          @project.complete = false
          @project.save
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
        category_deadline = Task.task_deadline(params[:category_id])
        project_deadline = Category.project_deadline(params[:project_id])
        if @task.deadline.present? && category_deadline != nil   
          if (category_deadline < @task.deadline) && (project_deadline < @task.deadline) 
            @project.deadline = @task.deadline
            @project.save
          elsif category_deadline < @task.deadline 
            @category.deadline = @task.deadline
            @category.save
          end
        elsif @task.deadline.present? && category_deadline == nil &&  project_deadline == nil
          @category.deadline = @task.deadline
          @category.save
          @project.deadline = @task.deadline
          @project.save
        elsif @task.deadline.present? && category_deadline == nil &&  project_deadline != nil
          if project_deadline < @task.deadline 
            @category.deadline = @task.deadline
            @category.save
            @project.deadline = @task.deadline
            @project.save
          end
        end
        task_complete = @category.tasks.where(complete: true).count.to_f
        task_total = @category.tasks.all.count.to_f  
        category_result = task_complete/task_total
        @category.progress = (category_result * 100)
        @category.save
        if @category.progress == 100
          @category.complete = true 
          @category.save    
        else
          @category.complete = false 
          @category.save
        end
        cat_complete = @project.categories.where(complete: true).count.to_f
        cat_total = @project.categories.all.count.to_f
        project_result = cat_complete/cat_total
        @project.progress = (project_result * 100)
        @project.save
        if @project.progress == 100
          @project.complete = true
          @project.save
        else
          @project.complete = false
          @project.save
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
