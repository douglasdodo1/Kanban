class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :tittle
      t.string :description
      t.string :status, default: "To do"
      t.integer :priority, default: 0
      t.string :assignee

      t.timestamps
    end
  end
end
