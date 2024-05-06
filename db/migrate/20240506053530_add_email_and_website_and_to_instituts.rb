class AddEmailAndWebsiteAndToInstituts < ActiveRecord::Migration[7.0]
  def change
    add_column :instituts, :email,:string
    add_column :instituts, :website,:string
  end
end
