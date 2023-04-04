class AddListedToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :listed, :boolean, default: false
  end
end
