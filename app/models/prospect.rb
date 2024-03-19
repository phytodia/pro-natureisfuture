class Prospect < ApplicationRecord

  def full_address
    [town,cp, country].compact.join(', ')
  end

  scope :ordered_by_date, -> { order(date_prospec: :asc) }
  scope :ordered_by_lastname, -> { order(lastname: :asc) }
  scope :ordered_by_firstname, -> { order(firstname: :asc) }

end
