class CommentsController < ApplicationController
  before_action(:load_artwork, only: [:index, :new, :create, :show, :edit, :update, :destroy] )
  before_action(:load_user, only: [:index, :new, :create, :show, :edit, :update, :destroy] )

  before_action(:load_comment, { only: [:edit, :update, :show, :destroy] })

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.artwork = @artwork
    @comment.user_id = current_user.id
    @comment.save

    redirect_to user_artwork_path(@user, @artwork)
  end

  def edit
  end

  def update
    @comment.update(comment_params)
    redirect_to user_artwork_path(@user, @artwork)
  end

  def destroy
    if params[:artwork_id]
      Comment.find(params[:id]).destroy
      redirect_to user_artwork_path(@user, @artwork)
    end
  end

  private

  def load_user
    return @user = Artwork.find_by(id: params[:artwork_id]).user
  end

  def load_artwork
    return @artwork = Artwork.find_by(id: params[:artwork_id])
  end

  def load_comment
    return @comment = Comment.find_by(id: params[:id])
  end

  def comment_params
    params.require(:comment).permit(:title, :content, :artwork_id, :user_id)
  end

  def require_current_user
    if !current_user?(@user)
      redirect_to root_path
    end
  end

end
