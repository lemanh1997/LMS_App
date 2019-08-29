class FavoritesController < ApplicationController
  before_action :load_follow

  def index
    if @resource == User.name
      @favorites_books = @favorable.favorite_books
      @favorites_authors = @favorable.favorite_authors
      @title = @favorable.name + " " + t(:text_follow)
      render "show_followed_user"
    else
      @favorites = @favorable.users
      @users = @favorable.users.paginate(page: params[:page], per_page: 7)
      @title = @favorable.class.to_s + " " + t(:text_follow)
      render "show_following"
    end
  end

  def create
    @favorable.favorites.create(user_id: current_user.id)
    redirect_to @favorable
  end

  def destroy
    @favorable.favorites.find_by(user_id: current_user.id).destroy
    redirect_to @favorable
  end

  private
  def load_follow
    # @resource = request.fullpath.split("/")[2].singularize.classify
    # case @resource
    # when User.name
    #   @favorable = @resource.constantize.find_by(id: params[:user_id])
    # when Book.name
    #   @favorable = @resource.constantize.find_by(id: params[:book_id])
    # when Author.name
    #   @favorable = @resource.constantize.find_by(id: params[:author_id])
    # end
    # if @favorable.nil?
    #   flash[:info] = t(:no_exits)
    #   redirect_to root_path
    # end
    @favorable = case
      when params[:user_id]
        User.find_by(id: params[:user_id])
      when params[:book_id]
        Book.find_by(id: params[:book_id])
      when params[:author_id]
        Author.find_by(id: params[:author_id])
      end
    @resource = @favorable.class.name
    return if @favorable.present?
    flash[:info] = t(:no_exits)
    redirect_to root_path
  end
end
