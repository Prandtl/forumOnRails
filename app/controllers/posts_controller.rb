class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @posts = Post.all.order("created_at DESC")
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.title.blank?
      flash.now[:alert] = 'You can\'t have a post without a title.'
      render 'new'
      return
    end

    if @post.content.blank?
      flash.now[:notice] = 'You should put some content in your post.'
      render 'new'
      return
    end

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    if current_user.id!=@post.user_id
      flash[:notice] = 'This is someone else\'s post. You cannot change it'
      redirect_to @post
    end
  end

  def update
    if post_params[:title].blank?
      flash.now[:alert] = 'You can\'t have a post without a title.'
      render 'edit'
      return
    end

    if post_params[:content].blank?
      flash.now[:notice] = 'You should put some content in your post.'
      render 'edit'
      return
    end

    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title,:content)
  end
end
