class AddMetroFilesToInstances < ActiveRecord::Migration[7.1]
  def change
    add_reference :instances, :metro_file, null: false, foreign_key: true
  end
end
