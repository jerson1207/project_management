class Project < ApplicationRecord
  belongs_to :user
  has_many :categories, dependent: :destroy

  validates :name, presence: true
  validates :name, length: {  in: 6..20 }
  validates :name, uniqueness:  { case_sensitive: false, message: "already exist" }
  validate :deadline_cannot_be_in_the_past 
  validate :deadline_cannot_be_less_than_category

 

  def deadline_cannot_be_less_than_category
    if self.categories.exists? 
      if category_max_deadline != false 
        if self.deadline.present? && self.deadline < category_max_deadline
          errors.add(:deadline, "cannot be lower than #{category_max_deadline}")
        end
      end      
    end
  end

  def category_max_deadline
    cat_deadline = Project.find(self.id).categories.where(deadline: Category.maximum("deadline"))
    if cat_deadline.count != 0
      cat_deadline.first.deadline
    else
      return false
    end
  end


  


  # id = self.id
  # project = Project.find(id).where(deadline: Category.maximum("deadline"))
  # if d.count != 0
  #   d.first.deadline
  # else
  #   return "No Deadline"
  # end
  
end
