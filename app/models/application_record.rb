class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

 

  def format_date(field_name)
    "#{field_name.slice(4..7)}-#{field_name.slice(0..1)}-#{field_name.slice(2..3)}"
  end

end
