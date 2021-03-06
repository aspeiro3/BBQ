class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # пользователь может создавать много событий
  has_many :events

  # пользователь может оставлять много комментариев
  has_many :comments
  has_many :subscriptions

  validates :name,
            presence: true,
            length: { maximum: 35 }

  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  private

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email)
      .update_all(user_id: self.id)
  end

  def set_name
    self.name = "Пользователь №#{rand(999)}" if self.name.blank?
  end
end
