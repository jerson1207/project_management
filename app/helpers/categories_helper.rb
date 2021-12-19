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
      return "No deadline"
    end
  end

  def cat_progress(number)
    if number == nil 
      return " No Task"
    else
      return number.ceil.to_s + "%"
    end
  end
  def total_task(id)
    category = Category.find(id)
    total = category.tasks.all.count
    return total
  end

  def total_task_complete(id)
    category = Category.find(id)
    total = category.tasks.where(complete: true).count
    return total
  end

end
