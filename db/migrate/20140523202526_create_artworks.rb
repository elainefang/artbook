class CreateArtworks < ActiveRecord::Migration
  def change
    create_table :artworks do |t|
      t.string :title
      t.string :description
      t.string :image_url
      t.references :user
      t.timestamps
    end
  end
end
