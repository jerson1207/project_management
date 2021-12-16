class AddDeadlineToCategory < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :deadline, :date
  end
end
