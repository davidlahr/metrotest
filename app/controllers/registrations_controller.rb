class RegistrationsController < Devise::RegistrationsController

  before_action :set_user, only:[:edit]
  # before_action :is_super_admin #, only:[:index, :edit, :admin_new, :destroy]
  
  
  def index
    @users = User.all
  end

  def show
    
  end

  def new
    super
  end
  
  def edit
    # @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: "User was successfully created." }
        # format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:notice] = "User successfully updated"  
        redirect_to users_path_url, notice:"Yo"
      else
        render :edit, status: :unprocessable_entity
        flash[:notice] = "User succ"  
      end
  end

  def destroy
    super
  end

  # controllers for admin menu
  def admin_new
    @user = User.new
  end

  def admin_edit
    
  end
  ##########################

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :company_id, :first_name, :last_name, :role)
  end

end