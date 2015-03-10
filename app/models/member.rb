class Member < ActiveRecord::Base
  @@capte_code = [0,1,2,3,4,5,6,7,8,9,'A','a','B','b','C','c','D','d','E','e','F','f','G','g','H','h','I','i','J','j','K','k','L','l','M','m','N','n','O','o','P','p','Q','q','R','r','S','s','T','t','U','u','W','w','V','v','X','x','Y','y','Z','z']
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :remember_me,:m_type,:status,:id


  def self.create_capte_code
    capte_code = @@capte_code.sample 4
    codeStr = capte_code.join('')
    return codeStr
  end

end
