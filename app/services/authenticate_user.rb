# Authenticate user based on the email and password

class AuthenticateUser
  def self.call(email, password)
    new.call(email, password)
  end

  def call(email, password)
    return nil if password != ENV['PASSWORD']

    user = User.find_by(email: email)

    if user
      GenerateNewToken.call(user)
      user
    else
      nil
    end
  end
end
