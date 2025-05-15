module ApplicationHelper

  include Pagy::Frontend

  def format_date(field_name)
    "#{field_name.slice(4..7)}-#{field_name.slice(0..1)}-#{field_name.slice(2..3)}"
  end

  def nice_date(datefield)
    datefield.strftime("%b %d, %Y")
  end

  def date_with_time(datefield)
    datefield.strftime("%m/%d/%Y %H:%M:%S")
  end

  def basic_date(datefield)
    datefield.strftime("%m/%d/%Y")
  end
end
