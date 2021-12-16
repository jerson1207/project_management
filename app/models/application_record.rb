class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def deadline_cannot_be_in_the_past
    if self.deadline.present? && self.deadline < Date.today
      errors.add(:dealine, "can't be in the past")
    end
  end

  
end
