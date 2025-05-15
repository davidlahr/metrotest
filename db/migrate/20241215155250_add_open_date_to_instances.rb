class AddOpenDateToInstances < ActiveRecord::Migration[7.1]
  def change
    add_column :instances, :date_opened, :date
  end
end
