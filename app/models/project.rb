class Project < ApplicationRecord
  has_many :categories, dependent: :destroy
end
