class AddCollaboratorToUser < ActiveRecord::Migration
  def change
    add_reference :users, :collaborator, index: true, foreign_key: true
  end
end
