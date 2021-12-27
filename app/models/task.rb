class Task < ApplicationRecord
  belongs_to :category
  validates :name, presence: true
  validates :name, length: { maximum: 500 }
  validates :name, uniqueness:  { case_sensitive: false, message: " already exist" }
  validate :deadline_cannot_be_in_the_past

  def self.update_deadline(pro_id, cat_id, date)
    project = Project.find(pro_id)
    category = Category.find(cat_id)
    # project = nil, cat = nil
    if project.deadline.nil? && category.deadline.nil?
      project.deadline = date
      project.save
      category.deadline = date
      category.save
    # project = nil, cat = present
    elsif project.deadline.nil? && category.deadline.present?
      if category.deadline < date
        category.deadline = date
        category.save
      end
    # project = present, cat = nil
    elsif project.deadline.present? && category.deadline.nil?
      category.deadline = date 
      category.save 
      if project.deadline < date 
        project.deadline = date 
        project.save 
      end
    # project = present, cat = present
    elsif project.deadline.present? && category.deadline.present?
      if category.deadline < date 
        category.deadline = date 
        category.save 
      end
      if project.deadline < date 
        project.deadline = date 
        project.save 
      end
    end
  end

  def self.update_progress(pro_id, cat_id)
    category = Category.find(cat_id)
    # calculate total task completed
    task_completed = category.tasks.where(complete: true).count.to_f
    # calculate total task
    task_total = category.tasks.all.count.to_f 

    average = task_completed / task_total
    category.progress = (average * 100)
    category.save
    # category progress update
    if category.progress == 100
      category.complete = true
      category.save 
    else
      category.complete = false 
      category.save
    end
    # project progress update
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
