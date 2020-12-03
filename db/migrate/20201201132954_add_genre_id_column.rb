class AddGenreIdColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :genre_id, :integar
  end
end
