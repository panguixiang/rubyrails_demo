class RegistrationsController < Devise::RegistrationsController
  def new
    session[:captCode]=nil? unless session[:captCode].nil?
    session[:captCode] = Member.create_capte_code
    super
  end

  def create
    build_resource(sign_up_params)
    capteCode = params[:capteCode]
    if capteCode.nil? || capteCode==''
      clean_up_passwords(:resource)
      flash[:error] = "验证码错误!"
      respond_with_navigational(resource) { render :new }
      return
    end
    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        flash[:email] =  params[:member][:email]
        render 'devise/registrations/success'
        return
        #respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      flash[:error] = "此账号已被注册!"
      clean_up_passwords resource
      respond_with resource
    end
  end

end
