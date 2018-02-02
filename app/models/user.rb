class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  has_many :authentications, dependent: :destroy
  has_secure_password

  has_many :articles
  # has_many :comments


  # Checks for duplicate emails 
  def self.check(email)
    if email
      find_by("email LIKE ?", "%#{email}%")          
    end    
  end

  # Create new acc with facebook
  def self.create_with_auth_and_hash(authentication, auth_hash)
  	user = self.create!(
			name: auth_hash["extra"]["raw_info"]['name'],
			email: auth_hash["extra"]["raw_info"]["email"],
			password: SecureRandom.hex(5)
  		)
  	user.authentications << authentication
  	return user
  end

  # Gets token 'facebook-oauth'
  def fb_token
  	x = self.authentications.find_by(provider: 'facebook')
  	return x.token unless x.nil?
  end

  # Google sign in feature
  def google_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication 
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except(:extra)
      redirect_to new_user_path, alert: @user.errors.full_messages.join("\n") 
    end
  end

  # Gets token 'google-oauth'
  def self.from_omniauth(access_token)
    data = access_token.info 
    user = User.where(email: data['email']).first

    unless user
      user = User.create(email: data['email'], password: SecureRandom.hex(5))          
    end
    user
  end

end
