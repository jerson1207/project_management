module ProjectsHelper

  def deadline(time)
    date = Project.find(time)
    if date != nil
      return date
    else
      return "No deadline setup"
    end
  end

  def pro_progress(number)
    if number == nil 
      return "No category listed"
    else
      return number 
    end
  end

end
