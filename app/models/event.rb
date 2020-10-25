class Event < ApplicationRecord

  # У события может быть только один пользователь
  belongs_to :user

  # У события может быть много комментариев
  has_many :comments
  has_many :subscriptions

  # Чтобы Рельсы понимали, какой именно класс будет лежать
  # в модели subscribers, надо указать source
  has_many :subscribers, through: :subscriptions, source: :user

  has_many :photos

  validates :user, presence: true

  validates :title, presence: true, length: { maximum: 255 }
  validates :address, presence: true
  validates :datetime, presence: true
end
