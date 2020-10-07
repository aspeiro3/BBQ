module ApplicationHelper
  def bootstrap_class_for(flash_type)
    {
      success: "alert-success",
      error: "alert-danger",
      alert: "alert-warning",
      notice: "alert-success"
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def bootstrap_flash(opts = {})
    flash.each do |msg_type, message|
      concat(
        content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)}", role: "alert") do
          concat content_tag(:button, '×', class: "close", data: { dismiss: 'alert' })
          concat message
        end
      )
    end

    return
  end

  def declension_of_words(number, option_one, option_two, option_three)
    ostatok = number % 10
    ostatok_11_14 = number % 100

    if ostatok.between?(5, 9) || ostatok == 0 || ostatok.between?(11, 14)
      return option_three
    end
    return option_one if ostatok == 1
    return option_two if ostatok.between?(2, 4)
  end

  def user_avatar(user)
#    if user.avatar_url.present?
#      user.avatar_url
#    else
      asset_pack_path('media/images/user.png')
#    end
  end
end
