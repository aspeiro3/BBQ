class User < ApplicationRecord
  EMAIL_FORMAT = /\A.+@.+\z/

  has_many :events

  validates :name,
            presence: true,
            length: { maximum: 35 }

  validates :email,
            presence: true,
            length: { maximum: 255 },
            uniqueness: true,
            format: { with: EMAIL_FORMAT }
end
