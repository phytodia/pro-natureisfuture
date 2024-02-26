module OrdersHelper
  def trimestre(date_today)
    trimestres =[ ["1","2","3"],["4","5","6"],["7","8","9"],["10","11","12"]]
    x = ((date_today.month - 1)/3).round(half: :down)
    return x
  end
end
