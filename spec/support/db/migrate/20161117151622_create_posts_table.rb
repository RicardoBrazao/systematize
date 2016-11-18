class CreatePostsTable < ActiveRecord::Migration
  def change
    create_table :posts do |p|
      p.string :title
      p.string :description
      p.integer :owner_id
      p.boolean :deleted

      p.timestamps
    end
  end
end
