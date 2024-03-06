module OrdersHelper

  def trimestre(date)
    trimestres =[ ["1","2","3"],["4","5","6"],["7","8","9"],["10","11","12"]]
    x = (date.month - 1)/3
    return {index: x ,trimestres: trimestres[x]}
  end
end
