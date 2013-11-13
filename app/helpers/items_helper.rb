module ItemsHelper

  def print_price(price)
    number_to_currency price
  end

  def print_status(status)
    if status
      "In season"
    else
      "Out of season"
    end
  end

end
