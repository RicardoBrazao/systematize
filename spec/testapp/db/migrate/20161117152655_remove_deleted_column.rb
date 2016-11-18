class RemoveDeletedColumn < ActiveRecord::Migration
  def up
    remove_column :posts, :deleted
  end

  def down
    add_column :posts, :deleted, :boolean
  end
end
