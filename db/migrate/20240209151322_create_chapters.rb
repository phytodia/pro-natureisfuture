class CreateChapters < ActiveRecord::Migration[7.0]
  def change
    create_table :chapters do |t|
      t.references :course, null: false, foreign_key: true
      t.string :titre
      t.text :content

      t.timestamps
    end
  end
end
