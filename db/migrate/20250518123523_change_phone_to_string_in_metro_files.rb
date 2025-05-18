class ChangePhoneToStringInMetroFiles < ActiveRecord::Migration[7.1]
  def change
    change_column :metro_files, :reporter_telephone_number, :string
  end
end
