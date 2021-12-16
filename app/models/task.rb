class Task < ApplicationRecord
  belongs_to :category
  validates :name, presence: true
  validates :name, length: { maximum: 500 }
  validates :name, uniqueness:  { case_sensitive: false, message: " already exist" }
  validate :deadline_cannot_be_in_the_past

  def self.task_deadline(task_id)
    category = Category.find(task_id)
    if category.deadline.present?
      return category.deadline
    else
      return nil
    end
  end
end
