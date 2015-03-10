class SessionsController < Devise::SessionsController

  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    sign_in(resource_name, resource)
    cookies[:email]=resource.email
    return render :json => {:success => true,:member=>resource.to_json}
  end

  def failure
    cookies[:email]=nil
    return render :json => {:success => false, :errors => ["Login failed."]}
  end

end
