class Category < ApplicationRecord
  belongs_to :project
  has_many :tasks, dependent: :destroy
  validates :name, presence: true
  validates :name, length: { in: 4..32  }
  validates :name, uniqueness:  { case_sensitive: false, message: " already exist" }
  validate :deadline_cannot_be_in_the_past 
  validate :deadline_cannot_be_less_than_task

  def deadline_cannot_be_less_than_task
    if self.tasks.exists? 
      if task_max_deadline != false 
        if self.deadline.present? && self.deadline < task_max_deadline
          errors.add(:deadline, "cannot be lower than #{task_max_deadline}")
        end
      end      
    end
  end

  def task_max_deadline 
    task_deadline = Category.find(self.id).tasks.where(deadline: Task.maximum("deadline"))
    if task_deadline.count != 0
      if task_deadline.first.deadline != nil
        return task_deadline.first.deadline  
      else
        return false 
      end   
    else
      return false
    end
  end

  def self.update_deadline(pro_id, date)
    project = Project.find(pro_id)
    # project.nil?
    if project.deadline.nil?
      project.deadline = date   
      project.save
    # project.presetnt?
    elsif project.deadline.present?
      if project.deadline < date 
        project.deadline = date 
        project.save 
      end      
    end
  end

  def self.update_progress(pro_id)
    # calculate total of category
    project = Project.find(pro_id)
    cat_complete = project.categories.where(complete: true).count.to_f
    cat_total = project.categories.all.count.to_f
    ave = cat_complete/cat_total
    project.progress = (ave * 100)
    project.save
    if project.progress == 100
      project.complete = true
      project.save
    else
      project.complete = false
      project.save
    end
  end

end
