class Prospect < ApplicationRecord

  def full_address
    [town,cp, country].compact.join(', ')
  end
end
