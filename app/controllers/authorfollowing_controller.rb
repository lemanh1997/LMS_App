class AuthorfollowingController < ApplicationController
  def index
    @title = t("layouts.header.text_author") + " " + t(:text_following)
    @user  = User.find(params[:user_id])
    @authors = @user.author_following.paginate(page: params[:page], per_page: 15)
  end
end
