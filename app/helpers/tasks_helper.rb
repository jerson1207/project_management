module TasksHelper

  def date_time(date)
    if date == nil
      return "none"
    else
      return date
    end
  end
  #category deadline
  def task_deadline(cat_id)
    category = Category.find(cat_id)
    date = category.deadline
    unless date == nil
      return date
    else
      return "No Deadline"
    end
  end
  def task_deadline_month(project, category, task)
    task = Project.find(project).categories.find(category).tasks.find(task)
    date = task.deadline
    unless date == nil
      return date.strftime("%b").upcase
    else
      return " "
    end
  end

  def task_deadline_day(project, category, task)
    task = Project.find(project).categories.find(category).tasks.find(task)
    date = task.deadline
    unless date == nil
      return date.strftime("%-d").upcase
    else
      return "N/A"
    end
  end

  def task_deadline_year(project, category, task)
    task = Project.find(project).categories.find(category).tasks.find(task)
    date = task.deadline
    unless date == nil
      return date.strftime("%Y").upcase
    else
      return " "
    end
  end
 
end
