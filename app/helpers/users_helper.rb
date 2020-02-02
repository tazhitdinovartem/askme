module UsersHelper
  def set_user_header(user)
    style_reg_exp = /\A[0-9A-Za-z]+\z/
    if user.header_color.match(style_reg_exp)
      user.header_color
    else
      user.header_color = '005a55'
    end
  end
end
