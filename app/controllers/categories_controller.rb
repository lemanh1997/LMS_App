class CategoriesController < ApplicationController
  before_action :set_category, only: :show
  
  def new
    @category = Category.new
  end

  def show
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Create category complete!"
      redirect_to @category
    else
      render :new
    end
  end

  private
  def category_params
    params.require(:category).permit(:name, :content)
  end

  def set_category
    @publisher = Publisher.find(params[:id]) 
  end

end
