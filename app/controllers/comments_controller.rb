class CommentsController < ApplicationController

  def index
    render json: Comment.order("created_at ASC").all
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment
    else
      render status: 400, nothing: true
    end
  end

  def show
    @comment = Comment.find(params:id])

    if @comment
      render json: @comment
    else
      render status: 400, nothing: true
    end
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      render json: @comment
    else
      render status: 400, nothing: true
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.destroy
      render json: {}
    else
      render status: 400, nothing: true
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:comment_text, :artwork_id, :commenter)
    end

end
