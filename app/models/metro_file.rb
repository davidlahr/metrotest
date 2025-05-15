class MetroFile < ApplicationRecord
  include Reusable
  belongs_to :company
  has_many :instances, dependent: :destroy

  

  def self.format_date(field_name)
    "#{field_name.slice(4..7)}-#{field_name.slice(0..1)}-#{field_name.slice(2..3)}"
  end

  def self.import_header_and_trailer(filename, company_id)
    
    #header format----------------------------------------------------------------------------------
    header_fields = [4,6,2,10,10,5,10,8,8,8,8,40,96,10,40,5,10,86] #<- the size of each field
    header_field_pattern = "A#{header_fields.join('A')}"
    
    #trailer format----------------------------------------------------------------------------------
    trailer_fields = [4,7,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,19] #<- the size of each field
    trailer_field_pattern = "A#{trailer_fields.join('A')}"
    
    f = File.open(filename) #<- reads first line of file (header)
    
    header = f.readline #<- reads first line of file (header)
    lines = f.to_a
    trailer = lines.last #<- reads last line of file (trailer)

    f.close

    if ["HEADER "].include?(header.slice(4..10))
      header_array = header.unpack(header_field_pattern) #<- parses the fields
    end
    
    if ["TRAILER"].include?(trailer.slice(4..10))
      trailer_array = trailer.unpack(trailer_field_pattern) #<- parses the fields
        
    end

    file_description = header_array + trailer_array #<- combines arrays and names the fields
      record_descriptor, record_identifer, cycle_identifier,innovis_program_identifier,equifax_program_identifer,experian_program_identifier,transunion_program_identifier,activity_date,date_file_created, program_date, program_revision_date, reporter_name, reporter_address, reporter_telephone_number, software_vendor_name, software_version_number, microbilt_prbc_program_identifer, reserved,
      record_descriptor, record_identifer, total_base_records, reserved, total_status_df, total_associated_j1, total_associated_j2, block_count, total_status_da, reserved, total_status_11, total_status_13, total_status_61, total_status_62, total_status_63, total_status_64, total_status_65, total_status_71, total_status_78, total_status_80, total_status_82, total_status_83, total_status_84, total_status_88, total_status_89, total_status_93, total_status_94, total_status_95, total_status_96, total_status_97, total_ecoa_z, total_employment_segments, total_original_creditor_segments, total_purchased_sold_segments, total_mortgage_segments, total_specialized_payment_segments, total_change_segments, total_ssns_all_segments, total_ssns_base_segment, total_ssn_j1, total_ssn_j2, total_dob_all, total_dob_j1, total_dob_j2, total_phone_numbers_all_segments, reserved = file_description
    
      MetroFile.create(
        record_descriptor: record_descriptor,
        record_identifer: record_identifer,
        cycle_identifier: cycle_identifier,
        innovis_program_identifier: innovis_program_identifier,
        equifax_program_identifer: equifax_program_identifer,
        experian_program_identifier: experian_program_identifier,
        transunion_program_identifier: transunion_program_identifier,
        activity_date: format_date(activity_date),
        date_file_created: format_date(date_file_created),
        program_date: format_date(program_date),
        program_revision_date: format_date(program_revision_date),
        reporter_name: reporter_name,
        reporter_address: reporter_address,
        reporter_telephone_number: reporter_telephone_number,
        software_vendor_name: software_vendor_name,
        software_version_number: software_version_number,
        microbilt_prbc_program_identifer: microbilt_prbc_program_identifer,
        total_base_records: total_base_records,
        # reserved: reserved,
        total_status_df: total_status_df,
        total_associated_j1: total_associated_j1,
        total_associated_j2: total_associated_j2,
        block_count: block_count,
        total_status_da: total_status_da,
        # reserved: reserved,
        total_status_11: total_status_11,
        total_status_13: total_status_13,
        total_status_61: total_status_61,
        total_status_62: total_status_62,
        total_status_63: total_status_63,
        total_status_64: total_status_64,
        total_status_65: total_status_65,
        total_status_71: total_status_71,
        total_status_78: total_status_78,
        total_status_80: total_status_80,
        total_status_82: total_status_82,
        total_status_83: total_status_83,
        total_status_84: total_status_84,
        total_status_88: total_status_88,
        total_status_89: total_status_89,
        total_status_93: total_status_93,
        total_status_94: total_status_94,
        total_status_95: total_status_95,
        total_status_96: total_status_96,
        total_status_97: total_status_97,
        total_ecoa_z: total_ecoa_z,
        total_employment_segments: total_employment_segments,
        total_original_creditor_segments: total_original_creditor_segments,
        total_purchased_sold_segments: total_purchased_sold_segments,
        total_mortgage_segments: total_mortgage_segments,
        total_specialized_payment_segments: total_specialized_payment_segments,
        total_change_segments: total_change_segments,
        total_ssns_all_segments: total_ssns_all_segments,
        total_ssns_base_segment: total_ssns_base_segment,
        total_ssn_j1: total_ssn_j1,
        total_ssn_j2: total_ssn_j2,
        total_dob_all: total_dob_all,
        total_dob_j1: total_dob_j1,
        total_dob_j2: total_dob_j2,
        total_phone_numbers_all_segments: total_phone_numbers_all_segments,
        company_id: company_id
      )
      
  end
  

end
