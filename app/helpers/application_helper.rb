module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.png'
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

  def show_answered_questions(questions)
    result = questions.select do |question|
      question.answer.present?
    end
    result.length
  end

  def show_not_answered_questions(questions)
    result = questions.select do |question|
      !question.answer.present?
    end
    result.length
  end
end
