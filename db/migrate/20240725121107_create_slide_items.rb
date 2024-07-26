class CreateSlideItems < ActiveRecord::Migration[7.0]
  def change
    create_table :slide_items do |t|
      t.string :link
      t.references :slider_home, null: false, foreign_key: true

      t.timestamps
    end
  end
end
