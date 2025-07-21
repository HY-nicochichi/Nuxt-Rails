class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :pass_enc, presence: true
  validates :name, presence: true
end
