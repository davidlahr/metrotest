class AddOrigAmtToInstances < ActiveRecord::Migration[7.1]
  def change
    add_column :instances, :highest_credit_or_original_loan_amount, :integer
  end
end
