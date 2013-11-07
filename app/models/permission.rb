class Permission < Struct.new(:user)

  def allow?(controller, action)
    if user.nil?
      controller == "items" && action.in?(%w[index show])
    elsif user.admin?
      true
    end
  end

end
