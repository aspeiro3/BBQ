class Subscription < ApplicationRecord

  belongs_to :event
  belongs_to :user, optional: true

  # Обязательно должно быть событие
  validates :event, presence: true

  # Проверки user_name и user_email выполняются,
  # только если user не задан
  # То есть для анонимных пользователей
  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: -> { user.present? }

  # Для конкретного event_id один юзер может подписаться только один раз (если юзер задан)
  validates :user, uniqueness: {scope: :event_id}, if: -> { user.present? }

  # один email может использоваться только один раз (если анонимная подписка)
  validates :user_email, uniqueness: {scope: :event_id}, unless: -> { user.present? }

  # анонимная подписка не будет создана при использовании Email зарегестрированого пользователя
  validate :subscription_not_created_with_email_registered_user, unless: -> { user.present? }

  # запрет подписки на свое событие
  validate :deny_subscription_to_your_event, if: -> { user.present? }

  # Если есть юзер, выдаем его имя,
  # если нет – дергаем исходный метод
  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  # Если есть юзер, выдаем его email,
  # если нет – дергаем исходный метод
  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def subscription_not_created_with_email_registered_user
    errors.add(:user_email, I18n.t('models.subscriptions.error')) if User.where(email: user_email).present?
  end

  def deny_subscription_to_your_event
    errors.add(:user_email) if event.user_id == user_id
  end
end
