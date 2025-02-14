class JsonWebToken
  def self.decode(token)
    HashWithINdifferentAccess.new(JWT.decode(token, Rails.application.credentials.secret_key_base)[0])
  rescue
    nil
  end
end
