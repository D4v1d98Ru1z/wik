class AddUserToCollaborator < ActiveRecord::Migration
  def change
    add_reference :collaborators, :user, index: true, foreign_key: true
  end
end
