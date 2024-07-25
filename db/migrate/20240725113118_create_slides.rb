class CreateSlides < ActiveRecord::Migration[7.0]
  def change
    create_table :slides do |t|
      t.string :link
      t.references :slider_home, null: false, foreign_key: true

      t.timestamps
    end
  end
end
