class AddFilenameToInstances < ActiveRecord::Migration[7.1]
  def change
    add_column :instances, :file_number, :integer
  end
end
