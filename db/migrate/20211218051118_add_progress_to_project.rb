class AddProgressToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :progress, :float
  end
end
