class AddSubheadingToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :subheading, :string
  end
end
