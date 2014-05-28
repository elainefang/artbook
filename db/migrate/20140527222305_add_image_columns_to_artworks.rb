class AddImageColumnsToArtworks < ActiveRecord::Migration
  def self.up
    add_attachment :artworks, :art_image
  end

  def self.down
    remove_attachment :artworks, :art_image
  end
end
