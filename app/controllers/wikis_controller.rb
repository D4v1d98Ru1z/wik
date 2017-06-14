class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]

    if @wiki.save
      flash[:notice] = "Your wiki was saved successfully"
      redirect_to @wiki
    else
      flash[:alert] = "There was an error saving your wiki. Please try again"
      render :new
    end
  end

  def edit
  end
end
