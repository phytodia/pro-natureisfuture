class AddChapoToBlogPost < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_posts, :chapo, :text
    add_column :blog_posts, :img_description, :text
  end
end
