class ChangeUserIdInPostsToInteger2 < ActiveRecord::Migration
  def change
    change_column :posts, :user_id, 'integer USING CAST(column_name AS integer)'
  end
end
