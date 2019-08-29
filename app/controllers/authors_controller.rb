class AuthorsController < ApplicationController
  before_action :set_author, only: :show

  def new
    @author = Author.new
  end

  def show
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      flash[:success] = "Create author complete!"
      redirect_to @author
    else
      render :new
    end
  end

  private
  def author_params
    params.require(:author).permit(:name, :nickname, :content)
  end

  def set_author
    @author = Author.find(params[:id])
  end

end
