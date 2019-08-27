class FollowingController < ApplicationController
  def index
    @title = t(:text_following)
    @user  = User.find(params[:user_id])
    @users = @user.following.paginate(page: params[:page], per_page: 15)
  end
end
