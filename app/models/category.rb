class Category < ApplicationRecord
  belongs_to :project
  has_many :tasks, dependent: :destroy
  validates :name, presence: true
  validates :name, length: { in: 6..20  }
  validates :name, uniqueness:  { case_sensitive: false, message: " already exist" }
  validate :deadline_cannot_be_in_the_past 
  validate :deadline_cannot_be_less_than_task

  def self.project_deadline(cat_id)
    project = Project.find(cat_id)
    if project.deadline.present?
      return project.deadline
    else
      return nil
    end
  end

  def deadline_cannot_be_less_than_task
    if self.tasks.exists? 
      if task_max_deadline != false 
        if self.deadline.present? && self.deadline < task_max_deadline
          errors.add(:deadline, "cannot be lower than #{task_max_deadline}")
        end
      end      
    end
  end
#return date if total task 0
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


end
