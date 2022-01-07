class TogglesController < ApplicationController 

  def status
    @project = Project.find(params[:project_id])
    @category = Project.find(params[:project_id]).categories.find(params[:category_id])
    @task = Project.find(params[:project_id]).categories.find(params[:category_id]).tasks.find(params[:task_id])
    @task.complete = !@task.complete
    if @task.save
      Task.update_progress(@project.id, @category.id)
      if @task.deadline.present?
        Task.update_deadline(@project.id, @category.id, @task.deadline)
      end
    end
    redirect_to project_category_tasks_path


  end
end