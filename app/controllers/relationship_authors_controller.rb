class RelationshipAuthorsController < ApplicationController
  before_action :logged_in_user

  def create
    @author = Author.find(params[:author_f_id])
    @author.follow_author(current_user)
    redirect_to @author
    # respond_to do |format|
    #   format.html { redirect_to request.referrer || @author }
    #   format.js
    # end
  end

  def destroy
    @author = RelationshipAuthor.find_by(author_f_id: params[:author_f_id]).author_f
    @author.unfollow_author(current_user)
    redirect_to @author
    # respond_to do |format|
    #   format.html { redirect_to request.referrer || @author }
    #   format.js
    # end
  end
end
