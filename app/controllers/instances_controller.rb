class InstancesController < ApplicationController
before_action :set_instance, only:[:show]
before_action :set_metro_file, only:[:metric, :index, :minors, :disputes, :comments, :invalid_ssns, :medical_states, :missing_names, :medical_balance,:bad_dofds,:no_dob_or_ssns]
before_action :require_signin
before_action :require_correct_company, only:[:show]
  
  def new_import
    @instance = Instance.new
    
  end  


  def import
    Instance.import(params[:import_file])
    redirect_to instances_url 
        
  end 
  
  def index
    if params[:metro_file_id]
      # @instances = @metrofile.instances.limit(@per_page).offset(@offset)
      @pagy, @instances = pagy(@metrofile.instances.all, page: params[:page], items: 9)
    else
      @instances = Instance.all
    end
  end

  def show
    
  end

  def new
    @instance = @metro_file.instances.new
    
  end

  def create
    
    Instance.import(:filename)
  end

  def metric
    @minors = Instance.under_18(@metrofile.id)
    @compliance_condition_codes = Instance.compliance_condition_exists(@metrofile.id).group(:compliance_condition_code).count
    @special_comments = Instance.special_comments(@metrofile.id).group(:special_comment).count
    @statuses = Instance.status_codes(@metrofile.id).group(:account_status).count
    @bad_ssns = Instance.check_ssn(@metrofile)
    @state_meds = Instance.medical_states(@metrofile.id)
    @balance_meds = Instance.medical_balance(@metrofile.id)
    @no_names = Instance.missing_names(@metrofile.id)
    @no_dob_or_ssns = Instance.dob_ssns(@metrofile.id)
    @dofds = Instance.bad_dofds(@metrofile.id)

  end

  def minors
    # test a scope here
    @pagy, @instances = pagy(Instance.under_18(@metrofile.id).limit(@per_page).offset(@offset))

  end

  def disputes
    @pagy, @instances = pagy(Instance.where(metro_file_id: params[:metro_file_id], compliance_condition_code: params[:compliance_condition_code]))
  end

  def comments
    @pagy, @instances = pagy(Instance.where(metro_file_id: params[:metro_file_id], special_comment: params[:special_comment]))
  end

  def invalid_ssns
    @bad_ssns = Instance.check_ssn(@metrofile)
    @pagy, @instances = pagy(Instance.where("id IN (?)", @bad_ssns))

  end

  def medical_states
    @pagy, @instances = pagy(Instance.medical_states(@metrofile.id).limit(@per_page).offset(@offset))
  end

  def medical_balance
    @mb = 0
    @pagy, @instances = pagy(Instance.medical_balance(@metrofile.id).limit(@per_page).offset(@offset))
  end

  def missing_names
    @pagy, @instances = pagy(Instance.missing_names(@metrofile.id).limit(@per_page).offset(@offset))
  end

  def no_dob_or_ssns
    @pagy, @instances = pagy(Instance.dob_ssns(@metrofile.id).limit(@per_page).offset(@offset))
  end

  def bad_dofds
    @pagy, @instances = pagy(Instance.bad_dofds(@metrofile.id).limit(@per_page).offset(@offset))
  end

private

  def set_instance
    @instance = Instance.find(params[:id])
  end

  def set_metro_file
    @metrofile = MetroFile.find_by_id(params[:metro_file_id])
  end
 

end
