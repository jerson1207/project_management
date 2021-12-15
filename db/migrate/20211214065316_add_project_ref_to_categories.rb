class AddProjectRefToCategories < ActiveRecord::Migration[6.1]
  def change
    add_reference :categories, :project, null: false, foreign_key: true
  end
end
