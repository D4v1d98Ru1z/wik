class CollaboratorController < ApplicationController
  def new
    @collaborator = Collaborator.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find_by_email(params[:collaborator][:user])
    @collaborator = @wiki.collaborators.new(user_id: @user.id, wiki_id: @wiki.id)

    if @collaborator.save
      flash[:notice] = "Collaborator #{:user} saved!"
    else
      flash.now[:alert] = "There was an error saving your collaborators, please try again."
    end
      redirect_to :back
  end

  def destroy
  end
end
