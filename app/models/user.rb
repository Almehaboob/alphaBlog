class User < ApplicationRecord
    has_many :articles, dependent: :destroy
    has_secure_password
  
    validates :username, presence: true, uniqueness: true, length: { in: 3..25 }
    validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 105 }
  end
  