class PostsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create, :edit, :destroy]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def edit
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])

    if current_user != @post.user
      redirect_to root_path, alert: "You have no permission"
    end
  end

  def update
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    @post = Post.update(post_params)
    redirect_to account_posts_path, notice: "Update success"
  end

  def destroy
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    @post.destroy
    flash[:alert] = "Post deleted"
    redirect_to account_posts_path
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

end
