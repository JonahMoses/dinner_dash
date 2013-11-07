class Permission < Struct.new(:user)

  def allow?(controller, action)
    if user.nil?
      controller == "items" && action.in?(%w[index show])
    elsif user.admin?
      true
    else
      controller == "items" && action.in?(%w[index show])
    end
  end

end
