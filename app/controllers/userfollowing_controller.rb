class UserfollowingController < ApplicationController
  def index
    @title = t(:text_follower)
    @author  = Author.find(params[:author_id])
    @users = @author.user_following.paginate(page: params[:page], per_page: 15)
  end
end
