class AddDeletedAtTimestamp < ActiveRecord::Migration
  def up
    add_column :posts, :deleted_at, :time
  end

  def down
    remove_column :posts, :deleted_at
  end
end
