module ApplicationHelper

  def image(path)
    File.open("app/assets/images/#{path}", "rb") do |file|
      raw file.read
    end
  end

  def project_deadline(id)
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

  def date_filter(deadline)
    if deadline.present?
      return deadline
    else
      return "No deadline"
    end
  end


end


  # def category_deadline(id)
  #   project = Project.find(id)
  #   date = project.deadline
  #   status = project.complete
  #   unless status == true
  #     if date != nil
  #       return date
  #     else
  #       return "No Deadline"
  #     end
  #   else
  #     return "Completed"
  #   end
  # end

  # def task_deadline(id)
  #   project = Project.find(id)
  #   date = project.deadline
  #   status = project.complete
  #   unless status == true
  #     if date != nil
  #       return date
  #     else
  #       return "No Deadline"
  #     end
  #   else
  #     return "Completed"
  #   end
  # end



