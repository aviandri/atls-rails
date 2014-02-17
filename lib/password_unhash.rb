module PasswordUnhash
  protected
  def password=(new_password)
    @password = new_password
    self.plain_password = new_password
    self.encrypted_password = password_digest(@password) if @password.present?
  end
end
