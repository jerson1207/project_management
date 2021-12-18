class TogglesController < ApplicationController 

  def status
    @project = Project.find(params[:project_id])
    @category = Project.find(params[:project_id]).categories.find(params[:category_id])
    @task = Project.find(params[:project_id]).categories.find(params[:category_id]).tasks.find(params[:task_id])
    @task.complete = !@task.complete
    @task.save
    task_complete = @category.tasks.where(complete: true).count.to_f
    task_total = @category.tasks.all.count.to_f
    category_result = task_complete/task_total
    @category.progress = (category_result * 100)
    @category.save
    if @category.progress == 100
      @category.complete = true 
      @category.save
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
    else
      @category.complete = false 
      @category.save
    end
    redirect_to project_category_tasks_path
  end
end