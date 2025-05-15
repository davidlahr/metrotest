class Instance < ApplicationRecord
    belongs_to :metro_file

    scope :under_18, ->(id) {where('date_of_birth >?', 18.years.ago).where(metro_file_id: id)}
    scope :compliance_condition_exists, ->(id) {where.not(compliance_condition_code:[nil,'']).where(metro_file_id: id)}
    scope :special_comments, ->(id) {where.not(special_comment:[nil,'']).where(metro_file_id: id)}
    scope :status_codes, ->(id) {where(metro_file_id: id)}
    scope :medical_states, ->(id) {where(state: ["IL","CO","CA","MN","NJ","VA"], creditor_classification:["02","A2"]).where metro_file_id: id}
    scope :medical_balance, ->(id) {where('highest_credit_or_original_loan_amount <?', 500).where(creditor_classification:["02","A2"]).where metro_file_id: id}
    scope :missing_names, ->(id) {where('first_name=? or surname=?', "", "").where metro_file_id: id}
    scope :dob_ssns, ->(id) {where(social_security_number:['000000000',nil], date_of_birth:[nil]).where metro_file_id: id}
    scope :bad_dofds, ->(id) {where('date_of_first_delinquency >= date_opened').where metro_file_id: id}

    
    def self.bad_ssn(number)
        check_list=[]
        number = number.to_s
        first_three = number.slice(0..2)
        second_two = number.slice(3..4)
        last_four = number.slice(5..8)
           
        check_list << (first_three.include? "000")
        check_list << (first_three.include? "666")
        check_list << (second_two.include? "00")
        check_list << (last_four.include? "0000")
        check_list << (number.chars.uniq.size.equal? 1) #<-checks if all digits are the same i.e 111111111
        check_list << (number.equal? "078051120")
        check_list << (number.equal? "123456789")
        check_list << (number.to_i.between?(987654320, 987654329))
        check_list << (number.count("a-zA-Z") > 0)
      
        check_list.include? true
        
    end
    
    def self.check_ssn(metrofile)
        only_bad_ssns = []
        @instances = Instance.where(metro_file_id: metrofile.id)
        @instances.each do |i|
            unless i.social_security_number == "000000000" || i.social_security_number.slice(0..4) == "00000"
                if bad_ssn(i.social_security_number)
                    only_bad_ssns << i.id
                end
            end
        end
        @instances = only_bad_ssns
    end
    
    
    def self.format_date(field_name)
        "#{field_name.slice(4..7)}-#{field_name.slice(0..1)}-#{field_name.slice(2..3)}"
    end

    def self.normalize_text(input)
        transliterate(input)
    end

    def self.file_counter
        if Instance.maximum(:file_number).nil?
            1
        else
            Instance.maximum(:file_number) + 1
        end
    end

    def self.original_creditor(filename)
        k1_positions =[] 
         #### checks first 5 lines for the position of K1
         File.foreach(filename).with_index do |line, line_num|
           if line_num.between?(1,5) 
             k1_positions << line.index('K1')
           end
         end
       # finds the most common position of K1 among the 5 lines
       positions_count = k1_positions.tally
       most_popular_position = positions_count.max_by{|k,v| v}
       k1_pos = most_popular_position[0]
       # p k1_pos
       k1_pos - 426
    end
    
    def self.import(filename, metro_file) #testing sample metro2 file
        blank_space = original_creditor(filename)
        fields = [4,1,14,1,20,2,30,1,2,8,9,9,3,1,9,9,2,1,24,2,2,9,9,9,8,8,8,8,1,17,25,20,20,1,9,8,10,1,2,2,32,32,20,2,9,1,1,blank_space,2,30,2] #<- the size of each field
        field_pattern = "A#{fields.join('A')}"
        File.foreach(filename) do |x|
            x = x.to_slug.transliterate.to_s #removes foreign characters > UTF-8 characters to ASCII
            if not ["HEADER ","TRAILER"].include?(x.slice(4..10))
                row = x.unpack(field_pattern)
                record_descriptor, processing_indicator, time_stamp, correction_indicator, identification_number, cycle_identifier, consumer_account_number, portfolio_type, account_type, date_opened, credit_limit, highest_credit_or_original_loan_amount, terms_duration, terms_frequency, scheduled_monthly_payment_amount, actual_payment_amount, account_status, payment_rating, payment_history_profile, special_comment, compliance_condition_code, current_balance, amount_past_due, original_charge_off_amount, billing_date, date_of_first_delinquency, date_closed, date_of_last_payment, reserved, consumer_transaction_type, surname, first_name, middle_name, generation_code, social_security_number, date_of_birth, telephone_number, ecoa_code, consumer_information_indicator, country_code, first_line_of_address, second_line_of_address, city, state, postal_zip_code, address_indicator, residence_code, blank, segment_identifier, original_creditor, creditor_classification = row
            
                
                Instance.create(consumer_account_number: consumer_account_number, account_status: account_status, 
                date_opened: format_date(date_opened), highest_credit_or_original_loan_amount: highest_credit_or_original_loan_amount,
                record_descriptor: record_descriptor, 
                processing_indicator:  processing_indicator, 
                time_stamp:  format_date(time_stamp), 
                correction_indicator:  correction_indicator, 
                identification_number:  identification_number, 
                cycle_identifier:  cycle_identifier, 
                portfolio_type:  portfolio_type, 
                account_type:  account_type, 
                credit_limit:  credit_limit, 
                terms_duration:  terms_duration, 
                terms_frequency:  terms_frequency, 
                scheduled_monthly_payment_amount:  scheduled_monthly_payment_amount, 
                actual_payment_amount:  actual_payment_amount, 
                payment_rating:  payment_rating, 
                payment_history_profile:  payment_history_profile, 
                special_comment:  special_comment, 
                compliance_condition_code:  compliance_condition_code, 
                current_balance:  current_balance, 
                amount_past_due:  amount_past_due, 
                original_charge_off_amount:  original_charge_off_amount, 
                billing_date:   format_date(billing_date), 
                date_of_first_delinquency:   format_date(date_of_first_delinquency), 
                date_closed:   format_date(date_closed), 
                date_of_last_payment:   format_date(date_of_last_payment), 
                reserved:  reserved, 
                consumer_transaction_type:  consumer_transaction_type, 
                surname:  surname, 
                first_name:  first_name, 
                middle_name:  middle_name, 
                generation_code:  generation_code, 
                social_security_number:  social_security_number, 
                date_of_birth:   format_date(date_of_birth), 
                telephone_number:  telephone_number, 
                ecoa_code:  ecoa_code, 
                consumer_information_indicator:  consumer_information_indicator, 
                country_code:  country_code, 
                first_line_of_address:  first_line_of_address, 
                second_line_of_address:  second_line_of_address, 
                city:  city, 
                state:  state, 
                postal_zip_code:  postal_zip_code, 
                address_indicator:  address_indicator, 
                residence_code:  residence_code,
                metro_file_id: metro_file.id,
                original_creditor: original_creditor, 
                creditor_classification: creditor_classification
                )
                # p x.slice(4..10)
            end
        end
    end

    
end

