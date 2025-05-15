class CreateInstances < ActiveRecord::Migration[7.1]
  def change
    create_table :instances do |t|
      t.string :consumer_account_number
      t.string :account_status

      t.timestamps
    end
  end
end
