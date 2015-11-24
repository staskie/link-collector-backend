# Generate new token for a user
#
class GenerateNewToken
  def self.call(user)
    new.call(user)
  end

  def call(user)
    user.update_attributes(token: SecureRandom.hex)
  end
end
