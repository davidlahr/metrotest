class AddCompanyToMetroFiles < ActiveRecord::Migration[7.1]
  def change
    add_reference :metro_files, :company, null: false, foreign_key: true
  end
end
