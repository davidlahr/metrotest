class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :street_address
      t.string :extra_address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :contact

      t.timestamps
    end
  end
end
