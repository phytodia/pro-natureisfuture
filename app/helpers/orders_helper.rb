module OrdersHelper

  TRIMESTRES = [ ["1","2","3"],["4","5","6"],["7","8","9"],["10","11","12"]]

  def trimestre(date)
    trimestres =[ ["1","2","3"],["4","5","6"],["7","8","9"],["10","11","12"]]
    x = (date.month - 1)/3
    return {index: x ,trimestres: trimestres[x]}
  end

  def last_trimestre_orders(orders_payed, current_trimestre)
    orders_last_trimestres = []
    if current_trimestre == 0
      TRIMESTRES[3].each do |trim|
        orders_last_trimestres << orders_payed.where("EXTRACT(month FROM custom_date) = ?", trim.to_i)
      end
    else
      TRIMESTRES[current_trimestre - 1].each do |trim|
        orders_last_trimestres << orders_payed.where("EXTRACT(month FROM custom_date) = ?", trim.to_i)
      end
    end
    return orders_last_trimestres.flatten
  end
end
