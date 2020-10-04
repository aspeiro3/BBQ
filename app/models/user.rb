class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events

  validates :name,
            presence: true,
            length: { maximum: 35 }

  before_validation :set_name, on: :create

  private

  def set_name
    self.name = "User №#{rand(999999999)}" if self.name.blank?
  end
end
