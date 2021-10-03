class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :rating
      t.decimal :total_gross
      t.text :description
      t.date :released_on
      t.string :director
      t.string :duration
      t.string :image_file_name, default: "placeholder.png"

      t.timestamps
    end
  end
end
