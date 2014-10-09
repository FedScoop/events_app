class UsersMailer < ActionMailer::Base
  default from: "ryan.verhey@fedscoop.com"

  def welcome_email(user)
    @user = user
    @url = "http://localhost:3000/users/validate/#{user.validation_hex}"
    mail to: @user.email, subject: 'Please validate your email address'
  end
end

# ActionMailer::Base.smtp_settings = {
#   :tls => true,
#   address: 'smtp.gmail.com',
#   port: 587,
#   domain: 'fedscoop.com',
#   user_name: 'ryan.verhey@fedscoop.com',
#   password: ENV['EMAIL_PASS'],
#   authentication: :plain,
#   enable_starttls_auto: true
# }
