class CreateSliderHomes < ActiveRecord::Migration[7.0]
  def change
    create_table :slider_homes do |t|

      t.timestamps
    end
  end
end
