class BorrowsController < ApplicationController
  before_action :set_borrow, only: [:update, :edit, :show, :destroy] 
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @borrow = Borrow.new
  end

  def edit
    @option_status = case
      when @borrow.default? && @borrow.book.number_of > 0
        Borrow.statuses.keys[0..2]
      when @borrow.default? && @borrow.book.number_of <= 0
        Borrow.statuses.keys[0..1] 
      when @borrow.denied?
        [Borrow.statuses.keys[1]]
      when @borrow.accepted?
        Borrow.statuses.keys[2..3]
      when @borrow.borrowed?
        Borrow.statuses.keys[3..4]
      when @borrow.returned?
        [Borrow.statuses.keys[4]]
      end
  end

  def show
  end

  def index
    if current_user.admin?
      @borrows = Borrow.paginate(page: params[:page], per_page: 10)
    else
      @borrows = Borrow.where("user_id = ?", current_user.id).paginate(page: params[:page], per_page: 10)
    end
  end

  def create
    @borrow = current_user.borrows.build(borrow_params)
    @borrow.book_id = params[:book_id]
    if @borrow.save
      flash[:success] = t(:create_complete)
    else
      flash[:danger] = t(:create_fails)
    end
    redirect_to Book.find_by(id: params[:book_id])
  end

  def update
    if @borrow.update_attributes(borrow_params)
      @borrow.update_borrow(params[:status])
      @borrow.book.update_borrow_book(params[:status])
      flash[:success] = t(:update_complete)
      redirect_to "/show_borrow"
    else
      flash[:info] = t(:edit_fails)
      redirect_to edit_book_borrow_path(params[:book_id],params[:id])
    end
  end

  def destroy
    Borrow.find_by(book_id: params[:book_id], user_id: params[:id]).destroy
    flash[:success] = t(:delete_complete)
    redirect_to request.referrer || current_user
  end

  private
  def borrow_params
    params.require(:borrow).permit(:start_date, :end_date, :status)
  end

  def set_borrow
    @borrow = Borrow.find_by(book_id: params[:book_id], user_id: params[:id])
    return if @borrow
    flash[:info] = t(:no_exits)
    redirect_to "/show_borrow"
  end

  def correct_user
    redirect_to root_path unless current_user?(@borrow.user) || current_user.admin?
  end
end
