class CreateMetroFiles < ActiveRecord::Migration[7.1]
  def change
    create_table :metro_files do |t|
      t.string :record_descriptor
      t.string :record_identifer
      t.string :cycle_identifier
      t.string :innovis_program_identifier
      t.string :equifax_program_identifer
      t.string :experian_program_identifier
      t.string :transunion_program_identifier
      t.date :activity_date
      t.date :date_file_created
      t.date :program_date
      t.date :program_revision_date
      t.string :reporter_name
      t.string :reporter_address
      t.integer :reporter_telephone_number
      t.string :software_vendor_name
      t.string :software_version_number
      t.string :microbilt_prbc_program_identifer
      t.integer :total_base_records
      t.string :total_status_df
      t.integer :total_associated_j1
      t.integer :total_associated_j2
      t.integer :block_count
      t.integer :total_status_da
      t.integer :total_status_11
      t.integer :total_status_13
      t.integer :total_status_61
      t.integer :total_status_62
      t.integer :total_status_63
      t.integer :total_status_64
      t.integer :total_status_65
      t.integer :total_status_71
      t.integer :total_status_78
      t.integer :total_status_80
      t.integer :total_status_82
      t.integer :total_status_83
      t.integer :total_status_84
      t.integer :total_status_88
      t.integer :total_status_89
      t.integer :total_status_93
      t.integer :total_status_94
      t.integer :total_status_95
      t.integer :total_status_96
      t.integer :total_status_97
      t.integer :total_ecoa_z
      t.integer :total_employment_segments
      t.integer :total_original_creditor_segments
      t.integer :total_purchased_sold_segments
      t.integer :total_mortgage_segments
      t.integer :total_specialized_payment_segments
      t.integer :total_change_segments
      t.integer :total_ssns_all_segments
      t.integer :total_ssns_base_segment
      t.integer :total_ssn_j1
      t.integer :total_ssn_j2
      t.integer :total_dob_all
      t.integer :total_dob_j1
      t.integer :total_dob_j2
      t.integer :total_phone_numbers_all_segments

      t.timestamps
    end
  end
end
