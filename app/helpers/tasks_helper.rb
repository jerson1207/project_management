module TasksHelper

  def date_time(date)
    if date == nil
      return "none"
    else
      return date
    end
  end

  def deadline(id)
    category = Category.find(id)
    date = category.deadline
    unless date == nil
      return date
    else
      return "No Deadline"
    end
  end
 
end
