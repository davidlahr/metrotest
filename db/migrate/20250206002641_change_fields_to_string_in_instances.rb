class ChangeFieldsToStringInInstances < ActiveRecord::Migration[7.1]
  def up
    change_column :instances, :social_security_number, :string
    change_column :instances, :telephone_number, :string

  end

  def down
    change_column :instances, :social_security_number, :integer
    change_column :instances, :telephone_number, :integer

  end

end
