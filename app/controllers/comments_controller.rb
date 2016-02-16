class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment_params = params.require(:comment).permit(:comment)

    if @comment_params[:comment].blank?
      flash[:alert] = 'You can\'t have a comment without any text.'
      redirect_to post_path(@post)
      return
    end

    if (current_user.userstatus == -1)
      flash.now[:alert] = 'You are banned, you can not comment.'
      redirect_to post_path(@post)
      return
    end

    @comment = @post.comments.create(@comment_params)
    @comment.user_id = current_user.id
    @comment.save

    if @comment.save
      redirect_to post_path(@post)
    else
      redirect_to 'new'
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if (current_user.id!=@comment.user_id && current_user.userstatus != 1)
      flash[:notice] = 'This is someone else\'s comment. You cannot change it'
      redirect_to post_path(@post)
      return
    end
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment_params = params.require(:comment).permit(:comment)

    if (current_user.userstatus == -1)
      flash.now[:alert] = 'You are banned, you are not allowed to modify comments.'
      redirect_to post_path(@post)
      return
    end

    if @comment_params[:comment].blank?
      flash.now[:alert] = 'You can\'t have a comment without any text.'
      render 'edit'
      return
    end

    if @comment.update(@comment_params)
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end
end
