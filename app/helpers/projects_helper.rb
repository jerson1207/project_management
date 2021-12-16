module ProjectsHelper

  def deadline(time)
    date = Project.find(time)
    if date != nil
      return date
    else
      return "No deadline setup"
    end
  end
end
