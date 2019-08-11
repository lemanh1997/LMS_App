class CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user, only: [:create, :edit, :update, :destroy]
  before_action :set_category, only: [:show, :edit, :update]
  before_action :before_destroy, only: :destroy

  def new
    @category = Category.new
  end

  def show
    @books = @category.books.paginate(page: params[:page])
  end

  def index
    @categories = Category.paginate(page: params[:page])
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    if(@category.save)
      flash[:success] = t(:text_flash_create)
      redirect_to categories_path
    else
      render :new
    end
  end

  def update
    if(@category.update_attributes(category_params))
      flash[:success] = t(:text_flash_update)
      redirect_to categories_path
    else
      render :edit
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = t(:text_flash_delete)
    redirect_to categories_path
  end

  private
  def category_params
    params.require(:category).permit(:name, :content)
  end

  def set_category
    @category = Category.find_by(id: params[:id])
    return if @category
    flash[:info] = t(:text_flash_info)
    redirect_to categories_path
  end

  def before_destroy
    @category = Category.find(params[:id])
    @category.books.each do |book|
      book.update_before_destroy_category
    end
  end
end
