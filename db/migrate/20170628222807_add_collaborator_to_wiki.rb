class AddCollaboratorToWiki < ActiveRecord::Migration
  def change
    add_reference :wikis, :collaborator, index: true, foreign_key: true
  end
end
