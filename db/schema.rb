# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_03_01_132149) do
  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "street_address"
    t.string "extra_address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.string "contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "instances", force: :cascade do |t|
    t.string "consumer_account_number"
    t.string "account_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_opened"
    t.integer "highest_credit_or_original_loan_amount"
    t.string "record_descriptor"
    t.string "processing_indicator"
    t.datetime "time_stamp"
    t.string "correction_indicator"
    t.string "identification_number"
    t.string "cycle_identifier"
    t.string "portfolio_type"
    t.string "account_type"
    t.integer "credit_limit"
    t.string "terms_duration"
    t.string "terms_frequency"
    t.integer "scheduled_monthly_payment_amount"
    t.integer "actual_payment_amount"
    t.string "payment_rating"
    t.string "payment_history_profile"
    t.string "special_comment"
    t.string "compliance_condition_code"
    t.integer "current_balance"
    t.integer "amount_past_due"
    t.integer "original_charge_off_amount"
    t.date "billing_date"
    t.date "date_of_first_delinquency"
    t.date "date_closed"
    t.date "date_of_last_payment"
    t.string "reserved"
    t.string "consumer_transaction_type"
    t.string "surname"
    t.string "first_name"
    t.string "middle_name"
    t.string "generation_code"
    t.string "social_security_number"
    t.date "date_of_birth"
    t.string "telephone_number"
    t.string "ecoa_code"
    t.string "consumer_information_indicator"
    t.string "country_code"
    t.string "first_line_of_address"
    t.string "second_line_of_address"
    t.string "city"
    t.string "state"
    t.string "postal_zip_code"
    t.string "address_indicator"
    t.string "residence_code"
    t.integer "file_number"
    t.integer "metro_file_id", null: false
    t.string "original_creditor"
    t.string "creditor_classification"
    t.index ["metro_file_id"], name: "index_instances_on_metro_file_id"
  end

  create_table "metro_files", force: :cascade do |t|
    t.string "record_descriptor"
    t.string "record_identifer"
    t.string "cycle_identifier"
    t.string "innovis_program_identifier"
    t.string "equifax_program_identifer"
    t.string "experian_program_identifier"
    t.string "transunion_program_identifier"
    t.date "activity_date"
    t.date "date_file_created"
    t.date "program_date"
    t.date "program_revision_date"
    t.string "reporter_name"
    t.string "reporter_address"
    t.integer "reporter_telephone_number"
    t.string "software_vendor_name"
    t.string "software_version_number"
    t.string "microbilt_prbc_program_identifer"
    t.integer "total_base_records"
    t.string "total_status_df"
    t.integer "total_associated_j1"
    t.integer "total_associated_j2"
    t.integer "block_count"
    t.integer "total_status_da"
    t.integer "total_status_11"
    t.integer "total_status_13"
    t.integer "total_status_61"
    t.integer "total_status_62"
    t.integer "total_status_63"
    t.integer "total_status_64"
    t.integer "total_status_65"
    t.integer "total_status_71"
    t.integer "total_status_78"
    t.integer "total_status_80"
    t.integer "total_status_82"
    t.integer "total_status_83"
    t.integer "total_status_84"
    t.integer "total_status_88"
    t.integer "total_status_89"
    t.integer "total_status_93"
    t.integer "total_status_94"
    t.integer "total_status_95"
    t.integer "total_status_96"
    t.integer "total_status_97"
    t.integer "total_ecoa_z"
    t.integer "total_employment_segments"
    t.integer "total_original_creditor_segments"
    t.integer "total_purchased_sold_segments"
    t.integer "total_mortgage_segments"
    t.integer "total_specialized_payment_segments"
    t.integer "total_change_segments"
    t.integer "total_ssns_all_segments"
    t.integer "total_ssns_base_segment"
    t.integer "total_ssn_j1"
    t.integer "total_ssn_j2"
    t.integer "total_dob_all"
    t.integer "total_dob_j1"
    t.integer "total_dob_j2"
    t.integer "total_phone_numbers_all_segments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id", null: false
    t.index ["company_id"], name: "index_metro_files_on_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "role"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "instances", "metro_files"
  add_foreign_key "metro_files", "companies"
  add_foreign_key "users", "companies"
end
