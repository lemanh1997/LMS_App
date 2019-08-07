class PublishersController < ApplicationController
  before_action :set_publisher, only: :show
  
  def new
    @publisher = Publisher.new
  end

  def show
  end

  def create
    @publisher = Publisher.new(publisher_params)
    if(@publisher.save)
      flash[:success] = "Create publisher complete"
      redirect_to @publisher
    else
      render :new
    end
  end

  private
  def publisher_params
    params.require(:publisher).permit(:name, :address, :content)
  end

  def set_publisher
    @publisher = Publisher.find(params[:id]) 
  end

end
