class FriendsController < ApplicationController
  # GET /friends
  # GET /friends.xml
  def index
    if params['status']
      @friends = Friend.all(:conditions => ["presence = ?", params['status']])
    else
      @friends = Friend.all
    end
    
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @friends }
    end
  end

  # GET /friends/1
  # GET /friends/1.xml
  def show
    @friend = Friend.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @friend }
    end
  end
end
