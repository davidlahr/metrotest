class ApplicationController < ActionController::Base
  include Pagy::Backend

  def is_super_admin
    if current_user
      unless current_user.role == "Site-Admin"
        redirect_to metro_files_url, notice: "Action Requires Site Admin"
      end
    else redirect_to new_user_session_url, notice: "Please Sign In"
    end
  end

  # helper_method :is_super_admin


  def require_signin
    unless current_user
      redirect_to new_user_session_url, notice: "Please Sign In"
    end
    
  end

  def require_correct_company
    if @metro_file
      unless current_user.company_id == @metro_file.company_id
        redirect_to metro_files_url, notice: "Action Not Authorized"
      end
    
    elsif @instance
      unless current_user.company_id == @instance.metro_file.company_id
        redirect_to metro_files_url, notice: "Action Not Authorized"
      end
    end
  end


end
