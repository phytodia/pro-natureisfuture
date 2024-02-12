class AddRankToChapter < ActiveRecord::Migration[7.0]
  def change
    add_column :chapters, :rank, :integer
  end
end
