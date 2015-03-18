class DeleteUserIdColumnFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :user_id, :string
  end
end
