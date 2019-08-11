class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @book = Book.find_by(id: params[:book_id])
    @comment = @book.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = t(:text_flash_create)
    else
      flash[:danger] = t(:text_flash_danger_3)
    end
    redirect_to @book
  end

  def destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
