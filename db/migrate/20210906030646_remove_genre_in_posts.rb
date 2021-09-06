class RemoveGenreInPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :genre, :string, foreign_key: true
  end
end
