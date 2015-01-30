class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @comment= Comment.new
  end
end
