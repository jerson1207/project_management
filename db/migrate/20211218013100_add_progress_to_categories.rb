class AddProgressToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :progress, :float
  end
end
