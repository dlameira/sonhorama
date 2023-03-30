class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :callout
      t.string :collaborators
      t.string :client
      t.date :date

      t.timestamps
    end
  end
end
