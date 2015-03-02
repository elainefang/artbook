class AddComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.text :content
      t.references :artwork
      t.user_id :integer
      t.timestamps
    end
  end
end
