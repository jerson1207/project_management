module ProjectsHelper

  def deadline(id)
    project = Project.find(id)
    date = project.deadline
    status = project.complete

    unless status == true
      if date != nil
        return date
      else
        return "No Deadline"
      end
    else
      return "Completed"
    end

    
  end

  def pro_progress(number)
    if number == nil 
      return "No category"
    else
      return number.ceil.to_s + "%"
    end
  end

  def total_category(id)
    project = Project.find(id)
    total = project.categories.all.count
    return total
  end

  def total_complete(id)
    project = Project.find(id)
    total = project.categories.where(complete: true).count
    return total
  end

end
