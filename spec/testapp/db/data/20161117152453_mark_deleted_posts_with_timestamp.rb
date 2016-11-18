class MarkDeletedPostsWithTimestamp < ActiveRecord::Migration
  def up
    Post.where(deleted: true).each do |post|
      post.deleted_at = Time.now
      post.save
    end
  end

  def down
    Post.where("deleted_at != ?", nil).each do |post|
      post.deleted = true
      post.save
    end
  end
end
