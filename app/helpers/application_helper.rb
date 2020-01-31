module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'any.jpeg'
    end
  end

  def inclination(amount, singular, singular_genitive, plural_genitive)
    if (amount % 100).between?(11, 14) 
      return "#{amount} #{plural_genitive}"
    end
    division_remainder = amount % 10
    if division_remainder == 1
      result = "#{amount} #{singular}"
    elsif division_remainder >= 2 && division_remainder <= 4
      result = "#{amount} #{singular_genitive}"
    else
      result = "#{amount} #{plural_genitive}"
    end
    return result
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end
