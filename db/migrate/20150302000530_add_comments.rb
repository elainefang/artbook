class AddComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.text :content
      t.references :artwork
      t.integer :user_id
      t.timestamps
    end
  end
end
