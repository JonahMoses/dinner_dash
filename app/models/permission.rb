class Permission < Struct.new(:user)

  def allow?(controller, action)
    controller == "items" && action == "index"
  end

end
