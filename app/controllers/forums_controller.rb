class ForumsController < ApplicationController
  before_filter :require_subdomain!, :only => :show
  before_filter :authenticate_user!, :except => :show
  
  def new
    @forum = Forum.new
  end
  
  def index
    @forums = current_user.forums.order(:name)
  end
  
  def create
    @forum = Forum.new(params[:forum])
    if @forum.save
      @forum.add_admin(current_user)
      redirect_to root_url(:subdomain => @forum.subdomain), :notice => "Forum created!"
    else
      render :new
    end
  end
  
end