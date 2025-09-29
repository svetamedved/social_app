class PostsController < ApplicationController
  before_action :require_login
  before_action :set_post, only: [:show, :destroy]

  def index
    @posts = Post.includes(:user => :account, :comments).recent.limit(50)
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, notice: "Post created successfully!"
    else
      @posts = Post.includes(:user => :account).recent.limit(50)
      render :index, status: :unprocessable_entity
    end
  end

  def show
    @comments = @post.comments.includes(:user => :account).recent
    @comment = Comment.new
  end

  def destroy
    if @post.user == current_user
      @post.destroy
      redirect_to posts_path, notice: "Post deleted successfully!"
    else
      redirect_to posts_path, alert: "You can only delete your own posts."
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
