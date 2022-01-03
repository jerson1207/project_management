class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :about
  def about

  end
  def home
    @projects = current_user.projects.all
  end

  def all_tasks
    @project = current_user.projects.all
  end
  
  def completed_tasks
    @project = current_user.projects.all
  end

  def uncomplete_tasks
    @project = current_user.projects.all
  end
end
