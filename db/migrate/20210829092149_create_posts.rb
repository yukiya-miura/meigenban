class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :content
      t.references :user, null: false, foreign_key: true
      t.string :genre_id
      t.string :author
      t.string :wordby

      t.timestamps
    end
  end
end
