class WikisController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Your wiki was saved successfully"
      redirect_to @wiki
    else
      flash[:alert] = "There was an error saving your wiki. Please try again"
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]

    if @wiki.save
      flash[:notice] = "Wiki was updated successfully"
      redirect_to @wiki
    else
      flash[:alert] = "There was an error updating the wiki. Please try again"
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.delete
      flash[:notice] = "#{@wiki.title} was successfully deleted"
      redirect_to wikis_path
    else
      flash[:alert] = "There was an error in deleting the wiki. Please try again"
      redirect_to @wiki
    end
  end

end
