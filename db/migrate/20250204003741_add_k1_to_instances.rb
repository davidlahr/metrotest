class AddK1ToInstances < ActiveRecord::Migration[7.1]
  def change
    add_column :instances, :original_creditor, :string
    add_column :instances, :creditor_classification, :string
  end
end
