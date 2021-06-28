class User < ApplicationRecord
  has_many :boards
  
  has_secure_password

  validates :name, presence: true, uniqueness: true, length: {maximum: 10}

  VALID_PASSWORD_REGEX =/\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{6,30}\z/
  validates :password, presence: true,
            format: { with: VALID_PASSWORD_REGEX,
             message: "は半角6~30文字英大文字・小文字・数字それぞれ１文字以上含む必要があります"}
end
