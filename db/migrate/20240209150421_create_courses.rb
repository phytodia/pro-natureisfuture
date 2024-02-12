class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :titre
      t.text :introduction
      t.integer :duree
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
