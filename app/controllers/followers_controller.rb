class FollowersController < ApplicationController
  def index
    @title = t(:text_follower)
    @user  = User.find(params[:user_id])
    @users = @user.followers.paginate(page: params[:page], per_page: 15)
  end
end
