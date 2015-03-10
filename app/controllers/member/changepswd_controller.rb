class Member::ChangepswdController< FatherController
  before_filter :authenticate_member!
  def edit
    @member = current_member
  end

  def update_password
    @member = Member.find(current_member.id)
    if @member.update_with_password(member_params)
      # Sign in the user by passing validation in case their password changed
      sign_in @member, :bypass => true
      redirect_to root_path
    else
      flash[:passwordError] =@member.errors[:password][0]
      flash[:password_confirmationError] =@member.errors[:password_confirmation][0]
      flash[:current_passwordError] =@member.errors[:current_password][0]
      redirect_to "/member/changepswd/edit"
    end
  end

  private

  def member_params
    # NOTE: Using `strong_parameters` gem
    params.required(:member).permit(:password, :password_confirmation, :current_password)
  end
end
