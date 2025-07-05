class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :pass_enc, presence: true
  validates :name, presence: true

  def self.encrypt_password(password = '')
    Digest::SHA256.hexdigest(password)
  end

  def password_matched?(password = '')
    User.encrypt_password(password) == pass_enc
  end
end
