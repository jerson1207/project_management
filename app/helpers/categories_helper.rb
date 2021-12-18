module CategoriesHelper

  def maximum_date(project, category)
    date = Project.find(project).categories.find(category).tasks.where(deadline: Task.maximum("deadline")).first
    
    if date == nil
      return "No Deadline"
    else
      return date
    end
  end

  def project_deadline(id)
    project = Project.find(id)
    date = project.deadline
    if date != nil
      return date
    else
      return "No deadline setup"
    end
  end

  def category_deadline(project, category)
    cat = Project.find(project).categories.find(category)
    date = cat.deadline
    if date != nil
      return date
    else
      return "No deadline for this category"
    end
  end

  def cat_progress(number)
    if number == nil 
      return " no task"
    else
      return number 
    end
  end

end
