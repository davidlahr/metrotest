class MetroFilesController < ApplicationController
  before_action :require_signin
  before_action :set_metro_file, only:[:show, :destroy]
  before_action :require_correct_company, only:[:show, :destroy]

  def new_import
    # @metro_file1 = MetroFile.new
  end  
  
  def import
    @metro_file = MetroFile.import_header_and_trailer(params[:import_file], current_user.company_id)
    Instance.import(params[:import_file], @metro_file)
    redirect_to metro_files_url 
    
  end
    
  def index
    # @metro_files = MetroFile.order("created_at DESC").all
    if current_user
      @metro_files = MetroFile.where(company_id: current_user.company_id).order("created_at DESC").all
    else
      redirect_to new_user_session_url, notice: "Please Log In to Continue"
    end

    
    
  end

  def show
    
  end
  
  def new
    
  end

  def create
    
  end

  def destroy
    @metro_file.destroy
    redirect_to metro_files_url, method: :get
  end

  private

  def set_metro_file
    @metro_file = MetroFile.find(params[:id])
  end

  
  
end
