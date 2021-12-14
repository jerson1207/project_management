class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.boolean :complete, default: false
      t.boolean :timelimit, default: false

      t.timestamps
    end
  end
end
